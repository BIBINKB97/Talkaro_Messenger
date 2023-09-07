import 'package:flutter/material.dart';
import 'package:talkaro/utils/constants.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {super.key,
      required this.name,
      required this.message,
      required this.time,
      required this.profilePic});
  final String name;
  final String message;
  final String time;
  final ImageProvider profilePic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight5,
        ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: profilePic,
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
