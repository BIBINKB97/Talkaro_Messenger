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
    return type == MessegeEnum.text
        ? Text(
            message,
            style: TextStyle(fontSize: 16, color: kwhite),
          )
        : type == MessegeEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : CachedNetworkImage(
                imageUrl: message,
              );
  }
}
