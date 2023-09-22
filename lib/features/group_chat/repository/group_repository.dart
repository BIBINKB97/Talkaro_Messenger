import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/repositories/common_firebase_storage_repository.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/models/group.dart';
import 'package:talkaro/models/user_model.dart';
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
        var userCollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: selectedContact[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();

        if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        }
      }
      var groupId = const Uuid().v1();

      String profileUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'group/$groupId',
            profilePic,
          );
      GroupModel group = GroupModel(
        senderId: auth.currentUser!.uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [auth.currentUser!.uid, ...uids],
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

  Future<void> addMemberToGroup(
      BuildContext context, String groupId, List<String> newMemberUid) async {
    try {
      var userCollection = await firestore.collection('users').get();

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        // String selectedPhoneNum = newMemberUid[0].replaceAll(
        //   ' ',
        //   '',
        // );
        for (int i = 0; i < newMemberUid.length; i++) {
          String selectedPhoneNum = newMemberUid[i];
          if (selectedPhoneNum == userData.phoneNumber) {
            try {
              DocumentSnapshot groupDoc =
                  await firestore.collection('groups').doc(groupId).get();

              if (groupDoc.exists) {
                List<dynamic> currentMembers = groupDoc['membersUid'];
                bool memberExists = false;

                for (int i = 0; i < newMemberUid.length; i++) {
                  if (!currentMembers.contains(userData.uid)) {
                    currentMembers.add(userData.uid);
                    await firestore.collection('groups').doc(groupId).update({
                      'membersUid': currentMembers,
                    });
                  } else {
                    memberExists = true;
                  }
                }

                if (memberExists) {
                  throw 'One or more members already exist in the group.';
                }
              } else {
                throw 'Group not found.';
              }
            } catch (e) {
              showSnackBar(context: context, content: e.toString());
            }
          } else {
            showSnackBar(
              context: context,
              content: 'This number does not exist on this app.',
            );
          }
        }
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
