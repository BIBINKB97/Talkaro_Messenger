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

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, required this.title, required this.onPressed});
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: ktheme,
              shape: StadiumBorder(),
              fixedSize: Size(130, 50)),
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
          )),
    );
  }
}
