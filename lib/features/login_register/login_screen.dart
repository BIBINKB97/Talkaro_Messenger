import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/login_register/widgets/text_style.dart';
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
        onSelect: (Country country) {
          setState(() {
            country = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Image(image: AssetImage("images/logo1.png")),
        ),
        Center(
            child: Column(
          children: [
            kheight20,
            CustomText(text: 'Talkaro will need to verify your phone number.'),
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
                      GestureDetector(
                        onTap: pickCountry,
                        child: Stack(
                          children: [
                            SizedBox(
                                width: 60,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset('images/Glb.png',
                                      fit: BoxFit.cover),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 44),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                      ),
                      if (country != null)
                        Text(
                          '+${country!.phoneCode}',
                          style: TextStyle(fontSize: 16),
                        ),
                      kwidth2,
                    ],
                  ),
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
      ],
    ));
  }
}
