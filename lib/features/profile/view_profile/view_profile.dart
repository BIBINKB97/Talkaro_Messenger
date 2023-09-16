import 'package:flutter/material.dart';
import 'package:talkaro/features/profile/view_profile/widgets.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ktheme,
        centerTitle: true,
        title: AppBarTitle(title: 'Amal Suresh'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              kheight80,
              CircleAvatar(
                backgroundImage: AssetImage("images/Jins.jpeg"),
                radius: 90,
              ),
              kheight10,
              Text(
                "Amal Suresh",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: kgrey),
              ),
              kheight10,
              Text(
                "9568423254",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, color: kgrey),
              ),
              kheight40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ThreeButtons(
                        icon: Icon(
                          Icons.message_outlined,
                          size: 30,
                        ),
                      ),
                      kheight10,
                      Text('Message')
                    ],
                  ),
                  kwidth30,
                  Column(
                    children: [
                      ThreeButtons(
                        
                        icon: Icon(
                          Icons.call_outlined,
                          size: 30,
                        ),
                      ),
                      kheight10,
                      Text('Audio')
                    ],
                  ),
                  kwidth30,
                  Column(
                    children: [
                      ThreeButtons(
                        icon: Icon(
                          Icons.videocam_outlined,
                          size: 35,
                        ),
                      ),
                      kheight10,
                      Text('Video')
                    ],
                  ),
                ],
              ),
              kheight20,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'offline is the new laxuary."Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
