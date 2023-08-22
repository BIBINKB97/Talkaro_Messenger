import 'package:flutter/material.dart';
import 'package:talkaro/screens/login_rejister/otp_verification.dart';
import 'package:talkaro/screens/login_rejister/widgets/text_form_widget.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class PhoneNumberVarification extends StatelessWidget {
  const PhoneNumberVarification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        kheight80,
        Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image(image: AssetImage("images/logo1.png")),
          ),
        ),
        kheight40,
        Center(
            child: Column(
          children: const [
            kheight20,
            Text(
              "Talkaro will need to verify your phone number",
              style: TextStyle(
                  fontSize: 17, wordSpacing: 2, fontWeight: FontWeight.w500),
            ),
            kheight10,
            Text(
              "Pick your country",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ],
        )),
        kheight20,
        TextFormWidget(label: 'Enter Phone Number'),
        kheight20,
        CommonButton(
            title: "verify",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OtpVerification()));
            })
      ],
    ));
  }
}
