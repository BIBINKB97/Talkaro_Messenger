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
          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: kwhite),
    );
  }
}
