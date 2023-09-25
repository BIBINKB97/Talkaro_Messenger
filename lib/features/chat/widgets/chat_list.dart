// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/chat/widgets/my_messege_card.dart';
import 'package:talkaro/features/chat/widgets/sender_messege_card.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/features/chat/controller/chat_controller.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const ChatList({
    super.key,
    required this.recieverUserId,
    required this.isGroupChat,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessegeEnum messegeEnum,
  ) {
    ref.read(messageReplyProvider.state).update((state) => MessageReplay(
          message: message,
          isMe: isMe,
          messegeEnum: messegeEnum,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Messege>>(
        stream: widget.isGroupChat
            ? ref
                .read(chatControllerProvider)
                .groupchatStream(widget.recieverUserId)
            : ref
                .read(chatControllerProvider)
                .chatStream(widget.recieverUserId),

                
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              final messegeData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messegeData.timeSent);

              if (!messegeData.isSeen &&
                  messegeData.recieverid ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.recieverUserId,
                      messegeData.messageId,
                    );
              }
              if (messegeData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messegeData.text,
                  date: timeSent,
                  type: messegeData.type,
                  repliedText: messegeData.repliedMessage,
                  username: messegeData.repliedTo,
                  repliedMessegeType: messegeData.repliedMessageType,
                  onLeftSwipe: () => onMessageSwipe(
                    messegeData.text,
                    true,
                    messegeData.type,
                  ),
                  isSeen: messegeData.isSeen,
                  messegeId: messegeData.messageId,
                recieverid: messegeData.recieverid,
                isGroupchat: false,
                );
              }
              return SenderMessegeCard(
                message: messegeData.text,
                date: timeSent,
                type: messegeData.type,
                username: messegeData.repliedTo,
                repliedMessegeType: messegeData.repliedMessageType,
                onRightSwipe: () => onMessageSwipe(
                  messegeData.text,
                  false,
                  messegeData.type,
                ),
                repliedText: messegeData.repliedMessage,
              );
            },
          );
        });
  }
}
