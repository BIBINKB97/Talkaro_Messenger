import 'package:flutter/material.dart';
import 'package:talkaro/features/calls/widgets/calls_card.dart';

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
