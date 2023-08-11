import 'package:flutter/material.dart';
import 'package:talkaro/screens/chat_screen/chat_list.dart';
import 'package:talkaro/screens/inbox/inbox.dart';
import 'package:talkaro/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talkaro',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChatListPage(),
      },
    );
  }
}
