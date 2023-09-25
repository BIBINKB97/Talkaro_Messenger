// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/features/chat/widgets/display_text_and_files.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class MessageReplayPreview extends ConsumerWidget {
  const MessageReplayPreview({super.key});

  void cancelReplay(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReplay = ref.watch(messageReplyProvider);
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),
      width: 350,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              kwidth10,
              Expanded(
                child: Text(
                  messageReplay!.isMe ? 'you' : 'opposit',
                ),
              ),
              GestureDetector(
                child: Icon(Icons.close),
                onTap: () => cancelReplay(ref),
              ),
              kwidth10
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: klight2,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DisplayTextAndFiles(
                message: messageReplay.message,
                type: messageReplay.messegeEnum,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
