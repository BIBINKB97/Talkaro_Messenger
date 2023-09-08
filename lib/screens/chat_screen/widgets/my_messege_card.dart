import 'package:flutter/material.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          color: klight2,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    kheight5,
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: kwhite,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
