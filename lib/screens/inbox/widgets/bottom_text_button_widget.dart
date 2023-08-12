import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class BottomTextBox extends StatelessWidget {
  const BottomTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 12.3,
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 225, 225),
            borderRadius: BorderRadius.circular(26)),
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: 360,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: kgrey,
              ),
            ),
            kwidth10,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Message",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 19),
                    border: InputBorder.none),
              ),
            ),
            Transform.rotate(
              angle: 47 * (99 / 179),
              child: Icon(
                Icons.attach_file,
                color: kgrey,
              ),
            ),
            kwidth20,
            CircleAvatar(
              radius: 22,
              backgroundColor: ktheme,
              child: Icon(
                Icons.send,
                color: kwhite,
              ),
            ),
            kwidth20
          ],
        ),
      ),
    );
  }
}
