import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talkaro/screens/login_rejister/login_screen.dart';

import 'package:talkaro/utils/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: Center(
          child: SizedBox(
        height: 180,
        width: 150,
        child: Column(
          children: const [
            Image(image: AssetImage("images/logo.png")),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: LinearProgressIndicator(
                color: ktheme,
                backgroundColor: kblack,
                minHeight: 3,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
