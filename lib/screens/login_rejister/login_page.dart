import 'package:flutter/material.dart';
import 'package:talkaro/utils/main_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, centerTitle: true, title: AppBarTitle(title: "Login")),
    );
  }
}
