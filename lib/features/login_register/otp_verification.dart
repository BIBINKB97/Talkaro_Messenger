import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  const OTPScreen({super.key, required this.verificationId});
  final String verificationId;

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ListView(children: [
      kheight80,
      Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: Image(image: AssetImage("images/logo1.png")),
        ),
      ),
      kheight20,
      Center(
          child: Text(
        "Enter your otp",
        style: TextStyle(
            fontSize: 17, wordSpacing: 2, fontWeight: FontWeight.w500),
      )),
      kheight80,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 140.0),
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: (val) {
            if (val.length == 6) {
              verifyOTP(ref, context, val.trim());
            }
          },
          decoration: InputDecoration(
            hintText: '-  -  -  -  -  -',
            hintStyle: TextStyle(fontSize: 30),
          ),
        ),
      ),
      kheight40,
      CommonButton(title: "veryfy", onPressed: () {})
    ]));
  }
}
