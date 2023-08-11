import 'package:flutter/material.dart';
import 'package:talkaro/utils/constants.dart';

class Tab1 extends StatelessWidget {
  const Tab1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ChatCard(
          name: 'Amal Suresh',
          message: " porche.. porcheeeee por",
          time: 'today',
        ),
        ChatCard(
          name: 'justin',
          message: "hellow",
          time: 'today',
        ),
        ChatCard(
          name: 'jithin chacko',
          message: "yeah bro",
          time: 'today',
        ),
        ChatCard(
          name: 'prasad ',
          message: "haha",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'jesson ',
          message: "okey ",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'sandeep ',
          message: "where are you ?",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'subith ',
          message: "nice",
          time: '01/08/2023',
        ),
        ChatCard(
          name: 'ridhin ',
          message: "nice",
          time: '01/08/2023',
        ),
        ChatCard(
          name: 'nabeel ',
          message: "nice",
          time: '02/08/2023',
        ),
      ],
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key,
      required this.name,
      required this.message,
      required this.time});
  final String name;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight5,
        ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage("images/user.png"),
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            message,
          ),
          trailing: Text(
            time,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
