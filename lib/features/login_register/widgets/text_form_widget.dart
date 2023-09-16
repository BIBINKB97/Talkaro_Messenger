import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            decoration: InputDecoration(
                label: Text(
                  label,
                  style: TextStyle(color: kblack),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        kheight20,
      ],
    );
  }
}
