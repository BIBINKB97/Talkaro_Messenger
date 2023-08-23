import 'package:flutter/material.dart';
import 'package:talkaro/models/chat_message_model.dart';
import 'package:talkaro/utils/colors.dart';

// ignore: must_be_immutable
class ChatList extends StatelessWidget {
  ChatList({super.key});
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello", messageType: "receiver"),
    ChatMessage(messageContent: "How are you ?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey amal, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "nothing bruh", messageType: "receiver"),
    ChatMessage(
        messageContent: "oke . how about a trip ?", messageType: "sender"),
    ChatMessage(messageContent: "that's cool", messageType: "receiver"),
    ChatMessage(messageContent: "oke . make a plan ", messageType: "sender"),
    ChatMessage(messageContent: " okey done", messageType: "receiver"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "receiver"
                    ? klight1
                    : klight2),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                messages[index].messageContent,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }
}
