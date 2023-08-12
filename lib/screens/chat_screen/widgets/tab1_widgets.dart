import 'package:flutter/material.dart';
import 'package:talkaro/utils/constants.dart';

import '../../inbox/inbox.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InboxPage(),
          )),
          child: ChatCard(
            name: 'Amal Suresh',
            message: "okey done",
            time: 'today',
          ),
        ),
        ChatCard(
          name: 'justin',
          message: "hellow",
          time: 'today',
        ),
        ChatCard(
          name: 'News plakkad',
          message: "lorem ipsum",
          time: 'today',
        ),
        ChatCard(
          name: 'Family',
          message: "ajith bro : hellow all",
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
