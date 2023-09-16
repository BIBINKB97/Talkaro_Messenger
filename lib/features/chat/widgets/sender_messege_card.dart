import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/features/chat/widgets/display_text_and_files.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class SenderMessegeCard extends StatelessWidget {
  final String message;
  final String date;
  final MessegeEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessegeEnum repliedMessegeType;

  const SenderMessegeCard(
      {Key? key,
      required this.message,
      required this.date,
      required this.type,
      required this.onRightSwipe,
      required this.repliedText,
      required this.username,
      required this.repliedMessegeType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplaying = repliedText.isNotEmpty;
    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            color: klight2,
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
                          bottom: 13,
                          left: 5,
                          right: 5,
                          top: 5,
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isReplaying) ...[
                        kheight5,
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kblack.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              kheight5,
                              DisplayTextAndFiles(
                                message: repliedText,
                                type: repliedMessegeType,
                              ),
                            ],
                          ),
                        ),
                        kheight5,
                      ],
                      DisplayTextAndFiles(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 5,
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
