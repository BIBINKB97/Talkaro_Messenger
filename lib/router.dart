import 'package:flutter/material.dart';
import 'package:talkaro/screens/login_rejister/login_screen.dart';
import 'package:talkaro/screens/login_rejister/user_information.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    case UserInformationScreen.routName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());

      
    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                body: Center(child: Text("something went wrong !")),
              ));
  }
}
