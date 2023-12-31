import 'package:flutter/material.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/features/group_chat/screens/create_group_screen.dart';
import 'package:talkaro/features/home_page/widgets/search_contacts.dart';
import 'package:talkaro/features/login_register/otp_verification.dart';
import 'package:talkaro/features/chat/screens/chat_screen.dart';
import 'package:talkaro/features/login_register/login_screen.dart';
import 'package:talkaro/features/login_register/user_information.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      final phoneNumber = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
        ),
      );

    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());

    case SearchContacts.routeName:
      return MaterialPageRoute(builder: (context) => SearchContacts());

    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final profilePic = arguments['profilePic'];
      final isGroupChat = arguments['isGroupChat'] ?? false;
      return MaterialPageRoute(
          builder: (context) => ChatScreen(
                profilePic: profilePic,
                name: name,
                uid: uid,
                isGroupChat: isGroupChat!,
              ));

    case CreateGroup.routeName:
      return MaterialPageRoute(builder: (context) => CreateGroup());

    default:
      return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: ErrorScreen(error: "something went wrong !")));
  }
}
