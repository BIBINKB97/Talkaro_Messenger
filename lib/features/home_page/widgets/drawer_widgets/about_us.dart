import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/main_widgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktheme,
        elevation: 0,
        title: AppBarTitle(title: 'Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "\nWelcome to Talkaro !\n\nTalkaro is a communication platform designed to connect people around the world through chat, video calls, and audio calls. Our mission is to provide a seamless and secure messaging experience that fosters meaningful connections and brings people closer together.\n\nOur Vision\n\nWe envision a world where distance is no barrier to communication. Talkaro is built on the belief that everyone deserves a reliable and private way to connect with loved ones, friends, and colleagues, no matter where they are.\n\nOur Team\n\nBehind Talkaro is a passionate team of developers, designers, and support staff dedicated to making your chat experience exceptional. We work tirelessly to bring you the latest features, ensure data security, and provide top-notch customer support.\n\nYour Feedback Matters\n\nAt Talkaro, we value your feedback and suggestions. Your insights help us improve our application and provide you with the best possible experience. If you have any comments, questions, or ideas, please don't hesitate to reach out to us at [Contact Email Address].\n\nStay Connected\n\nWe're excited to have you as a part of the Talkaro community. Stay connected, share moments, and enjoy the power of communication with Talkaro.\n\nPrivacy and Security\n\nYour privacy and data security are our top priorities. For information on how we handle your data, please refer to our Privacy Policy.\n\nThank You for Choosing Talkaro\n\nThank you for choosing Talkaro as your messaging platform. We appreciate your trust in us and look forward to serving you in the best way possible.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
