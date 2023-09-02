import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CallsCard(
          name: 'jesson',
          time: "just now",
          icon: Icons.call,
        ),
        CallsCard(
          name: 'Family',
          time: "3 minutes ago",
          icon: Icons.videocam,
        ),
        CallsCard(
          name: 'jithin chacko',
          time: "15 minutes ago",
          icon: Icons.videocam,
        ),
        CallsCard(
          name: 'prasad ',
          time: "today",
          icon: Icons.call,
        ),
        CallsCard(
          name: 'jesson ',
          time: "yesterday ",
          icon: Icons.call,
        ),
        CallsCard(
          name: 'sandeep ',
          time: "yesterday",
          icon: Icons.videocam,
        ),
      ],
    );
  }
}

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