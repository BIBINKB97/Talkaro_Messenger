import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';

class ThreeButtons extends StatelessWidget {
  const ThreeButtons({super.key, required this.icon});
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration:
          BoxDecoration(color: ktheme, borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        onPressed: () {},
        icon: icon,
        color: kwhite,
      ),
    );
  }
}
