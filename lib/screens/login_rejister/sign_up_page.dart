import 'package:flutter/material.dart';
import 'package:talkaro/screens/home_page/home_page.dart';
import 'package:talkaro/screens/login_rejister/login_page.dart';
import 'package:talkaro/screens/login_rejister/widgets/text_form_widget.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
      kheight10,
      Center(
        child: Text(
          "Sign-Up",
          style: TextStyle(
              color: ktheme, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      kheight40,
      kheight10,
      TextFormWidget(label: 'Enter your Email'),
      TextFormWidget(label: 'Password'),
      TextFormWidget(label: 'Confirm Password'),
      kheight20,
      CommonButton(
          title: "Sign up",
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          }),
      kheight80,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an acconut ?",
            style: TextStyle(fontSize: 16),
          ),
          kwidth10,
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 16, color: ktheme, fontWeight: FontWeight.w600),
            ),
          )
        ],
      )
    ]));
  }
}
