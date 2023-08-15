import 'package:flutter/material.dart';
import 'package:talkaro/screens/profile/edit_profile/widgets.dart';

import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ktheme,
        centerTitle: true,
        title: AppBarTitle(title: "Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kheight80,
            Center(
              child: Stack(
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/user.png"),
                    radius: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 135.0, top: 145),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: ktheme,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: kwhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kheight20,
            TextFormProfile(
              hintText: ' Enter Name',
              label: "Name",
            ),
            TextFormProfile(
              hintText: " Enter something about you",
              label: "About",
            ),
            TextFormProfile(
              hintText: ' Enter Phone Number ',
              label: "phone",
            ),
            kheight20,
            CommonButton(title: " save ",
            onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
