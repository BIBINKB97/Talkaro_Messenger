import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key, required this.tabtitle});
  final String tabtitle;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        height: 50,
        width: 148,
        child: Center(
          child: Text(
            tabtitle,
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}