import 'package:flutter/material.dart';
import 'package:talkaro/screens/home_page/home_page.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
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
        "we have sent an SMS with a code",
        style: TextStyle(
            fontSize: 17, wordSpacing: 2, fontWeight: FontWeight.w500),
      )),
      kheight80,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: TextFormField(),
      ),
      kheight40,
      CommonButton(
          title: "veryfy",
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          })
    ]));
  }
}
