import 'package:flutter/material.dart';
import 'package:talkaro/screens/home_page/home_page.dart';
import 'package:talkaro/screens/login_rejister/forgot_password.dart';
import 'package:talkaro/screens/login_rejister/widgets/text_form_widget.dart';
import 'package:talkaro/screens/login_rejister/sign_up_page.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          TextFormWidget(label: 'User Name'),
          TextFormWidget(label: 'Password'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    "forgot password ?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              kheight20,
              CommonButton(
                title: 'Login',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              kheight40,
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      indent: 40,
                      endIndent: 5,
                      color: ktheme,
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: ktheme,
                      endIndent: 40,
                      indent: 5,
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              kheight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: kwhite,
                    backgroundImage: AssetImage("images/google-icon.png"),
                  ),
                  kwidth20,
                  Text(
                    "Sign in with google",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              kheight20,
              Divider(
                thickness: 1,
                color: ktheme,
                indent: 40,
                endIndent: 40,
              ),
              kheight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kwidth20,
                  Text('Dont have an account ?',
                      style: TextStyle(fontSize: 16)),
                  kwidth20,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: ktheme,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: kwhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
