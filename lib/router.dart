import 'package:flutter/material.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:talkaro/features/chat/screens/chat_screen.dart';
import 'package:talkaro/features/login_register/login_screen.dart';
import 'package:talkaro/features/login_register/user_information.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());

    case SelsectContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => SelsectContactScreen());



    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(builder: (context) => ChatScreen(
        name: name,
        uid: uid,
      ));
    default:
      return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: ErrorScreen(error: "something went wrong !")));
  }
}
