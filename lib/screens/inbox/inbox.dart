import 'package:flutter/material.dart';
import 'package:talkaro/screens/profile/view_profile/widgets.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: AppBar(
            backgroundColor: kAppbarWhite,
            elevation: 0,
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "images/user.png",
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                AppBarTitle(title: "Amal Suresh"),
                Text(
                  'online',
                  style: TextStyle(color: kblack, fontSize: 16),
                )
              ],
            ),
            actions: const [
              ThreeButtons(icon: Icon(Icons.call_outlined)),
              kwidth10,
              ThreeButtons(icon: Icon(Icons.videocam_outlined)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Today"),
            kheight40,
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                          color: klight1,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'hi',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            kheight40,
            SizedBox(
              width: 300,
              child: Image(image: AssetImage("images/secret heaven1.jpeg")),
            )
          ],
        ),
      ),
    );
  }
}
