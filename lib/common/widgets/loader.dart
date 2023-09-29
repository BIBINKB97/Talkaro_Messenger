import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talkaro/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 100,
          width: 100,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                ktheme,
                BlendMode.srcATop,
              ),
              child: Lottie.asset('images/loading1.json'))),
    );
  }
}
