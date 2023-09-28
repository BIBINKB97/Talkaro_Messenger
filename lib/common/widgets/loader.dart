import 'package:flutter/material.dart';
import 'package:talkaro/utils/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          kheight10,
          Text('Loading...'),
          kheight10,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
