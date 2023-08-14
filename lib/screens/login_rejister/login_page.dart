import 'package:flutter/material.dart';
import 'package:talkaro/screens/login_rejister/widgets/text_form_widget.dart';
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
          kheight40,
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
                padding: const EdgeInsets.only(right: 25.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "forgot password ?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              kheight10,
              CommonButton(title: 'Login'),
              kheight20,
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
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
                        indent: 5,
                      ),
                    )
                  ],
                ),
              )
            ],

            
          ),
        ],
      ),
    );
  }
}
