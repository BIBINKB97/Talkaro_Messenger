import 'package:flutter/material.dart';
import 'package:talkaro/models/chat_message_model.dart';
import 'package:talkaro/utils/colors.dart';

// ignore: must_be_immutable
class ChatList extends StatelessWidget {
  ChatList({super.key});
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello", messageType: "reciever"),
    ChatMessage(messageContent: "How are you ?", messageType: "reciever"),
    ChatMessage(
        messageContent: "Hey amal, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "reciever"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "nothing bruh", messageType: "reciever"),
    ChatMessage(
        messageContent: "oke . how about a trip ?", messageType: "sender"),
    ChatMessage(messageContent: "that's cool", messageType: "reciever"),
    ChatMessage(messageContent: "oke . make a plan ", messageType: "sender"),
    ChatMessage(messageContent: " okey done", messageType: "reciever"),
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
            alignment: (messages[index].messageType == "reciever"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "reciever"
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
