import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/features/chat/repository/chat_repository.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Messege>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessege(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    final messageReplay = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessege(
            context: context,
            text: text,
            reciverUserId: recieverUserId,
            senderUser: value!,
            messageReplay: messageReplay,
          ),
        );
        
   
  }

  void sendFileMessege(
    BuildContext context,
    File file,
    String recieverUserId,
    MessegeEnum messegeEnum,
  ) {
    final messageReplay = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessege(
              context: context,
              file: file,
              recieverUserId: recieverUserId,
              senderUserData: value!,
              messegeEnum: messegeEnum,
              ref: ref,
              messageReplay: messageReplay),
        );
         ref.read(messageReplyProvider.state).update((state) => null);
  }
}
