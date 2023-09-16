import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/screens/chat_screen/widgets/my_messege_card.dart';
import 'package:talkaro/screens/chat_screen/widgets/sender_messege_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({super.key, required this.recieverUserId});

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
        stream:
            ref.read(chatControllerProvider).chatStream(widget.recieverUserId),
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
