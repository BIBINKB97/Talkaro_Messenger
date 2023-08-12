import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kwhite),
    );
  }
}
