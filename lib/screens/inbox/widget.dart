import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class BottomTextBox extends StatelessWidget {
  const BottomTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 12.5,
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: 360,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: ktheme,
                size: 28,
              ),
            ),
            kwidth10,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
                    border: InputBorder.none),
              ),
            ),
            Transform.rotate(
              angle: 47 * (99 / 179),
              child: Icon(
                Icons.attach_file,
                color: ktheme,
                size: 28,
              ),
            ),
            kwidth20,
            Transform.rotate(
              angle: 45 * (99 / 178.9),
              child: Icon(
                Icons.send,
                color: ktheme,
                size: 28,
              ),
            ),
            kwidth20
          ],
        ),
      ),
    );
  }
}
