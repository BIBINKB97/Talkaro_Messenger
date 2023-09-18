import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/models/group.dart';
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

  Stream<List<GroupModel>> chatGroups() {
    return chatRepository.getChatGroups();
  }

  Stream<List<Messege>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  Stream<List<Messege>> groupchatStream(String gorupId) {
    return chatRepository.getGroupChatStream(gorupId);
  }

  void sendTextMessege(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    final messageReplay = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessege(
            context: context,
            text: text,
            reciverUserId: recieverUserId,
            senderUser: value!,
            messageReplay: messageReplay,
            isGroupChat: isGroupChat,
          ),
        );
  }

  void sendFileMessege(
    BuildContext context,
    File file,
    String recieverUserId,
    MessegeEnum messegeEnum,
    bool isGroupChat,
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
            messageReplay: messageReplay,
            isGroupChat: isGroupChat,
          ),
        );
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  void setChatMessageSeen(
    BuildContext context,
    String revieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageSeen(
      context,
      revieverUserId,
      messageId,
    );
  }
}
