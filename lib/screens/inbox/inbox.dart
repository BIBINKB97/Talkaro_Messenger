import 'package:flutter/material.dart';
import 'package:talkaro/screens/inbox/widgets/bottom_text_button_widget.dart';
import 'package:talkaro/screens/inbox/widgets/chat_list.dart';
import 'package:talkaro/screens/profile/view_profile/view_profile.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: ktheme,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "images/user.png",
              ),
            ),
          ),
          title: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ViewProfile())),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppBarTitle(title: "Amal Suresh"),
                Text(
                  'online',
                  style: TextStyle(color: kwhite, fontSize: 16),
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.call_rounded,
                    color: kwhite,
                  ),
                  kwidth20,
                  Icon(
                    Icons.videocam_rounded,
                    color: kwhite,
                  ),
                  kwidth20,
                  Icon(
                    Icons.more_vert,
                    color: kwhite,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text("today")),
            Stack(
              children: [
                BottomTextBox(),
                ChatList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
