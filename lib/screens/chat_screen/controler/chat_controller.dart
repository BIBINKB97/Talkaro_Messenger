import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/screens/chat_screen/repositories/chat_repository.dart';
import 'package:talkaro/screens/login_rejister/auth/controller/auth_controller.dart';

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
      BuildContext context, String text, String recieverUserId) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessege(
            context: context,
            text: text,
            reciverUserId: recieverUserId,
            senderUser: value!,
          ),
        );
  }
}
