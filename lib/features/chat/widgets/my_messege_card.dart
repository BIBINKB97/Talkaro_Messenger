import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/features/chat/repository/chat_repository.dart';
import 'package:talkaro/features/chat/widgets/display_text_and_files.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class MyMessageCard extends ConsumerWidget {
  final String message;
  final String date;
  final MessegeEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessegeEnum repliedMessegeType;
  final bool isSeen;
  final String recieverid;
  final String messegeId;
  final bool isGroupchat;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessegeType,
    required this.isSeen,
    required this.recieverid,
    required this.messegeId,
    required this.isGroupchat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isReplaying = repliedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Do you want to delete this message?',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: const Text(
                        'This action will delete this messages from the chat forever !'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          ref
                              .read(chatRepositoryProvider)
                              .deleteMessageFromMessageSubcollection(
                                  recieverUserId: recieverid,
                                  messegeId: messegeId,
                                  isGroupChat: isGroupchat);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              color: ktheme,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Stack(
                children: [
                  Padding(
                    padding: type == MessegeEnum.text
                        ? EdgeInsets.only(
                            left: 10,
                            right: 30,
                            top: 5,
                            bottom: 15,
                          )
                        : EdgeInsets.only(
                            bottom: 7,
                            left: 5,
                            right: 5,
                            top: 5,
                          ),
                    child: Container(
                      constraints: BoxConstraints(minWidth: 25),
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
                          Container(
                            constraints:
                                BoxConstraints(maxHeight: 400, maxWidth: 400),
                            child: DisplayTextAndFiles(
                              message: message,
                              type: type,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 5,
                    child: Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        kwidth5,
                        Icon(isSeen ? Icons.done_all : Icons.done,
                            size: 15,
                            color: isSeen ? Colors.blue : Colors.white60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
