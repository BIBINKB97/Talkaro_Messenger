import 'package:flutter/material.dart';

import 'package:talkaro/screens/chat_screen/home_page.dart';

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
          iconTheme: IconThemeData(color: Colors.black)),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
