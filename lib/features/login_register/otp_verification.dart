import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/login_register/widgets/text_style.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class OTPScreen extends ConsumerStatefulWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  final String phoneNumber;
  const OTPScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  void verifyOTP(BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, widget.verificationId, userOTP);
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  Timer? _timer;
  int _start = 60;
  String getFormattedTime() {
    final minutes = (_start / 60).floor();
    final seconds = _start % 60;
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
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
          kheight50,
          const Text(
            'Verify your OTP',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          kheight20,
          SizedBox(
            child: OtpTextField(
              focusedBorderColor: ktheme,
              cursorColor: ktheme,
              numberOfFields: 6,
              borderColor: ktheme,
              showFieldAsBox: true,
              keyboardType: TextInputType.number,
              onSubmit: (val) {
                if (val.length == 6) {
                  verifyOTP(context, val.trim());
                  Navigator.pushReplacementNamed(
                      context, '/user-informationScreen');
                }
              },
            ),
          ),
          kheight40,
          _start > 0
              ? Text(
                  'Time remaining  : ${getFormattedTime()}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(text: "Did'nt received a code?"),
                      InkWell(
                        onTap: () {
                          ref
                              .read(authControllerProvider)
                              .signInWithPhone(context, widget.phoneNumber);
                        },
                        child: CustomText(
                          text: "Resend OTP",
                          color: ktheme,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
