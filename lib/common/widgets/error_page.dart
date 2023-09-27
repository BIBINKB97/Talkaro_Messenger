import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talkaro/utils/colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset('images/nonetwork.json')),
          const Text(
            'Please check your Internet Connection !',
            style: TextStyle(
              color: kwhite,
              fontSize: 16,
            ),
          ),
        ],
      )),
    );
  }
}
