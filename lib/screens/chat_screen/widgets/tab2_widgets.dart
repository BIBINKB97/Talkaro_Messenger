import 'package:flutter/material.dart';
import 'package:talkaro/screens/chat_screen/widgets/tab1_widgets.dart';

class Tab2 extends StatelessWidget {
  const Tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
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
          name: 'MTCHS PKD',
          message: "amal : yeah bro",
          time: 'today',
        ),
        ChatCard(
          name: 'DEVS kerala',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'Flutter community',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'Dart devs',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'world of IT',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'Inspiring expressions',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
        ChatCard(
          name: 'safari',
          message: "lorem ipsum",
          time: 'yesterday',
        ),
      ],
    );
  }
}
