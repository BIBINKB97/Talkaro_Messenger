import 'dart:async';

import 'package:flutter/material.dart';

import 'package:talkaro/utils/colors.dart';

import '../login_rejister/phone_number_verification.dart';

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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => PhoneNumberVarification()));
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
