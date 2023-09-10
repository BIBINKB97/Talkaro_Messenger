import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/repositories/common_firebase_storage_repository.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/models/user_model.dart';
import 'package:talkaro/utils/snack_bar.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();

        var user = UserModel.fromMap(userData.data()!);

        contacts.add(ChatContact(
          name: user.name,
          profilePic: user.profilePic,
          contactId: chatContact.contactId,
          timeSent: chatContact.timeSent,
          lastMessege: chatContact.lastMessege,
        ));
      }
      return contacts;
    });
  }

  Stream<List<Messege>> getChatStream(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messeges')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Messege> messeges = [];
      for (var document in event.docs) {
        messeges.add(Messege.fromMap(document.data()));
      }
      return messeges;
    });
  }

  void _saveDataToContactsSubCollection(
    UserModel sendersUserData,
    UserModel reciverUserData,
    String text,
    DateTime timeSent,
    String reciverUserId,
  ) async {
    var recieverChatContact = ChatContact(
      name: sendersUserData.name,
      profilePic: sendersUserData.profilePic,
      contactId: sendersUserData.uid,
      timeSent: timeSent,
      lastMessege: text,
    );
    await firestore
        .collection('users')
        .doc(reciverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );
    var senderChatContact = ChatContact(
      name: reciverUserData.name,
      profilePic: reciverUserData.profilePic,
      contactId: reciverUserData.uid,
      timeSent: timeSent,
      lastMessege: text,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(reciverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessegeToMessegeSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messegeId,
    required String username,
    required String recieverUserName,
    required MessegeEnum messegeType,
  }) async {
    final messege = Messege(
      senderId: auth.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      type: messegeType,
      timeSent: timeSent,
      messegeId: messegeId,
      isSeen: false,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messeges')
        .doc(messegeId)
        .set(messege.toMap());

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messeges')
        .doc(messegeId)
        .set(messege.toMap());
  }

  void sendTextMessege({
    required BuildContext context,
    required String text,
    required String reciverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel reciverUserData;

      var userDataMap =
          await firestore.collection('users').doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);

      var messegeId = const Uuid().v1();

      _saveDataToContactsSubCollection(
        senderUser,
        reciverUserData,
        text,
        timeSent,
        reciverUserId,
      );
      _saveMessegeToMessegeSubcollection(
          recieverUserId: reciverUserId,
          text: text,
          timeSent: timeSent,
          messegeType: MessegeEnum.text,
          messegeId: messegeId,
          recieverUserName: reciverUserData.name,
          username: senderUser.name);
    } catch (e) {
      ShowSnackBar(context: context, content: e.toString());
    }
  }

  void sendFileMessege({
    required BuildContext context,
    required File file,
    required String recieverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessegeEnum messegeEnum,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = Uuid().v1();
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            'chat/${messegeEnum.type}/${senderUserData.uid}/$recieverUserId /$messageId',
            file,
          );
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMsg;

      switch (messegeEnum) {
        case MessegeEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessegeEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessegeEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessegeEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }

      _saveDataToContactsSubCollection(
        senderUserData,
        recieverUserData,
        contactMsg,
        timeSent,
        recieverUserId,
      );
      _saveMessegeToMessegeSubcollection(
        recieverUserId: recieverUserId,
        text: imageUrl,
        timeSent: timeSent,
        messegeId: messageId,
        username: senderUserData.name,
        recieverUserName: recieverUserData.name,
        messegeType: messegeEnum,
      );
    } catch (e) {
      ShowSnackBar(context: context, content: e.toString());
    }
  }
}
