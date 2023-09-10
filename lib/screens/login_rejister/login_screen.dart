import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/screens/login_rejister/auth/controller/auth_controller.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-Screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void   sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      ShowSnackBar(context: context, content: 'fill out all the fields');
    }
  }

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
      kheight40,
      Center(
          child: Column(
        children: [
          kheight20,
          Text('Talkaro will need to verify your phone number.'),
          kheight40,
          Container(
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: ktheme),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 60,
                          child: IconButton(
                              onPressed: pickCountry,
                              icon: Icon(
                                Icons.language,
                                color: ktheme,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, left: 40),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    ),
                    if (country != null)
                      Text(
                        '+${country!.phoneCode}',
                        style: TextStyle(fontSize: 16),
                      ),
                  ],
                ),
                kwidth10,
                Expanded(
                  child: SizedBox(
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                    ),
                  ),
                ),
              ],
            ),
          ),
          kheight40,
          CommonButton(
            title: 'Send OTP',
            onPressed: sendPhoneNumber,
          ),
        ],
      )),
    ]));
  }
}
