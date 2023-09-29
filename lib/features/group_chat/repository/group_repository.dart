// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/repositories/common_firebase_storage_repository.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/models/group.dart';
import 'package:uuid/uuid.dart';

final groupRepositoryProvider = Provider(
  (ref) => GroupRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  GroupRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void createGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var usercollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo:
                  selectedContact[i].phones[0].number.replaceAll(' ', ''),
            )
            .get();
        if (usercollection.docs.isNotEmpty && usercollection.docs[0].exists) {
          uids.add(usercollection.docs[0].data()['uid']);
        }
      }
      var groupId = const Uuid().v1();
      String profileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase('group/$groupId', profilePic);
      GroupModel group = GroupModel(
        senderId: auth.currentUser!.uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [
          auth.currentUser!.uid,
          ...uids,
        ],
        timeSent: DateTime.now(),
      );
      await firestore.collection('groups').doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<GroupModel> groupData(String groupId) {
    return firestore.collection('groups').doc(groupId).snapshots().map(
          (event) => GroupModel.fromMap(
            event.data()!,
          ),
        );
  }

  List<int> selectedContactsIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
    } else {
      selectedContactsIndex.add(index);
    }
  }

  Future<void> addMemberToGroup(
    BuildContext context,
    String groupId,
    List<String> newMemberUids,
  ) async {
    try {
      DocumentReference groupRef = firestore.collection('groups').doc(groupId);
      DocumentSnapshot groupDoc = await groupRef.get();

      if (groupDoc.exists) {
        List<dynamic> currentMembers = groupDoc['membersUid'];

        List<String> membersToAdd = [];
        for (int i = 0; i < newMemberUids.length; i++) {
          if (!currentMembers.contains(newMemberUids[i])) {
            membersToAdd.add(newMemberUids[i]);
          }
        }

        if (membersToAdd.isNotEmpty) {
          currentMembers.addAll(membersToAdd);
          await groupRef.update({
            'membersUid': currentMembers,
          });

          log('New members added: $membersToAdd');
          showSnackBar(
            context: context,
            content: 'Member added successfully.',
          );
          Navigator.pop(context);
        } else {
          throw 'Selected members are already part of the group.';
        }
      } else {
        throw 'Group not found.';
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
