import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talkaro/screens/login_rejister/widgets/text_form_widget.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      kheight80,
      Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset("images/PW.json"),
        ),
      ),
      kheight20,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Text(
          "Please enter the email address associated with your account. We will send you a link to reset your password",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      kheight10,
      TextFormWidget(label: "Enter Your Email Address"),
      kheight20,
      CommonButton(title: "Reset", onPressed: () {})
    ]));
  }
}
