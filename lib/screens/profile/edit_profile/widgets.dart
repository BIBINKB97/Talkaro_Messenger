import 'package:flutter/material.dart';
import 'package:talkaro/utils/constants.dart';

import '../../../utils/colors.dart';

class TextFormProfile extends StatelessWidget {
  const TextFormProfile(
      {super.key, required this.hintText, required this.label});
  final String hintText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
            cursorColor: ktheme,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                suffixIcon: Icon(Icons.edit),
                label: Text(label),
                labelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          kheight20
        ],
      ),
    );
  }
}
