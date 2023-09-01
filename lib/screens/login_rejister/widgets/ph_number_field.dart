import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField(
      {super.key,
      required this.label,
      required this.countrycode,
      required this.onpressed});
  final String label;
  final String countrycode;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon:
                IconButton(onPressed: onpressed, icon: Icon(Icons.language)),
            prefix: Text(countrycode),
            label: Text(
              label,
              style: TextStyle(color: kblack),
            ),
          )),
    );
  }
}
