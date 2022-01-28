import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class InitialsAvatar extends StatelessWidget {
  String initials = "";
  double fontSize;

  InitialsAvatar(String text, {this.fontSize = 24, Key? key})
      : super(key: key) {
    if (text.trim().isNotEmpty) {
      var nameparts = text.split(" ");
      if (nameparts.isNotEmpty) {
        initials = nameparts[0][0].toUpperCase();
      }
      if (nameparts.length > 1) {
        initials += nameparts[1][0].toUpperCase();
      }
    }
    // if (text.contains(RegExp(r'[A-Z]'))) {}
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kButtonColor,
      child: Text(
        initials,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
