import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/screens/chat_screen/widgets/vido_player.dart';
import 'package:talkaro/utils/colors.dart';

class DisplayTextAndFiles extends StatelessWidget {
  final String message;
  final MessegeEnum type;

  const DisplayTextAndFiles({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();

    return type == MessegeEnum.text
        ? Text(
            message,
            style: const TextStyle(
              color: kwhite,
              fontSize: 16,
            ),
          )
        : type == MessegeEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await audioPlayer.play(UrlSource(message));
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                  ),
                );
              })
            : type == MessegeEnum.video
                ? VideoPlayerItem(
                    videoUrl: message,
                  )
                : type == MessegeEnum.gif
                    ? CachedNetworkImage(
                        imageUrl: message,
                      )
                    : CachedNetworkImage(
                        imageUrl: message,
                      );
  }
}
