import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/utils/colors.dart';

class DisplayFilesAndText extends StatelessWidget {
  final String messege;
  final MessegeEnum type;

  const DisplayFilesAndText({
    super.key,
    required this.messege,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessegeEnum.text
        ? Text(
            messege,
            style: TextStyle(fontSize: 16, color: kwhite),
          )
        : CachedNetworkImage(imageUrl: messege);
  }
}
