import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/models/messege.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/screens/chat_screen/widgets/my_messege_card.dart';
import 'package:talkaro/screens/chat_screen/widgets/sender_messege_card.dart';

// ignore: must_be_immutable
class ChatList extends ConsumerWidget {
  final String recieverUserId;

  const ChatList({super.key, required this.recieverUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Messege>>(
        stream: ref.read(chatControllerProvider).chatStream(recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              final messegeData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messegeData.timeSent);
              
              if (messegeData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
               
                return MyMessageCard(
                  message: messegeData.text,
                  date: timeSent,
                );
              }
              return SenderMessageCard(
                message: messegeData.text,
                date: timeSent,
              );
            },
          );
        });
  }
}
