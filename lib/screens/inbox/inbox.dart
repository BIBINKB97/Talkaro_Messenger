import 'package:flutter/material.dart';
import 'package:talkaro/screens/inbox/widget.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppBarTitle(title: "Amal Suresh"),
                Text(
                  'online',
                  style: TextStyle(color: kblack, fontSize: 16),
                )
              ],
            ),
            actions: [
              Row(
                children: const [
                  Icon(
                    Icons.call,
                    color: ktheme,
                    size: 25,
                  ),
                  kwidth20,
                  Icon(
                    Icons.videocam,
                    color: ktheme,
                    size: 25,
                  ),
                  kwidth30
                ],
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          BottomTextBox(),
        ],
      ),
    );
  }
}
