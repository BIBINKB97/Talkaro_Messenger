import 'package:flutter/material.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/screens/chat_screen/widgets/display_text_and_files.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessegeEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessegeEnum repliedMessegeType;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessegeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          color: ktheme,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessegeEnum.text
                    ? EdgeInsets.only(
                        left: 10,
                        right: 30,
                        top: 5,
                        bottom: 10,
                      )
                    : EdgeInsets.only(
                        bottom: 10,
                        left: 5,
                        right: 5,
                        top: 5,
                      ),
                child: Column(
                  children: [
                    kheight5,
                    DisplayTextAndFiles(
                      message: message,
                      type: type,
                    ),
                    kheight5,
                  ],
                ),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
