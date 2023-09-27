import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/main_widgets.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          padding: EdgeInsets.all(20),
          child: Text(
            "Welcome to Talkaro! \nWe are dedicated to safeguarding your privacy and ensuring the security of your personal information. \nThis Privacy Policy explains how we collect, use, and protect your data when you use our chat application.\n1. Information We CollectWe collect the following types of information :  \nUser Profile Information : When you sign up for Talkaro, we ask for your phone Number. You may also choose to upload a profile picture.Chat Data : We store the messages, images, and other content you send and receive on Talkaro. This data is essential for delivering your messages.Usage Information : We gather data about your usage of Talkaro, including the times and dates of your interactions and your device information.\n2. How We Use Your InformationWe use your information for the following purposes : \nProviding Services : We use your data to provide you with the Talkaro chat service, including message delivery and chat features.Improvement :  \nWe analyze user behavior to improve our application, offer personalized content, and enhance your experience.\n3.Information Sharing : \nWe respect your privacy. We do not sell your personal information to third parties. However, we may share your information under specific circumstances : Chat Partners : Your messages and content are shared with your chat partners to enable communication.Service Providers : We work with trusted third-party service providers who assist us in delivering Talkaro's services.Legal Requirements : We may disclose your information in response to legal requests, such as court orders or law enforcement inquiries.\n4. SecurityYour data security is our priority :  \nWe implement industry-standard security measures to protect your information, but please be aware that no method of data transmission over the internet is entirely secure.\n5. Your ChoicesYou have control over your information :\n Account Management : You can access, update, or delete your account information through the Talkaro application.Data Control : You can manage the data you share within the application's settings.\n6. Changes to this Privacy PolicyWe may update this Privacy Policy to reflect changes in our practices or legal requirements. Any updates will be posted here, and the date at the top will indicate the latest revision.\n7. Contact Us If you have any questions or concerns regarding this Privacy Policy, please reach out to us at bibinkochumalayil007@gamil.com.\n\nBy using Talkaro, you agree to this Privacy Policy. \nPlease take the time to read and review it regularly for any updates.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
