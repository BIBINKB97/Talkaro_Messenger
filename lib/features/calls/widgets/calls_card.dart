import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class CallsCard extends StatelessWidget {
  const CallsCard(
      {super.key, required this.name, required this.time, required this.icon});
  final String name;
  final String time;
  final IconData icon;

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
              time,
            ),
            trailing: Icon(
              icon,
              size: 30,
              color: ktheme,
            )),
      ],
    );
  }
}