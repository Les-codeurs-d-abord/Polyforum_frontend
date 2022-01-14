import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class InitialsAvatar extends StatelessWidget {
  String initials = "";

  InitialsAvatar(String text, {Key? key}) : super(key: key) {
    var nameparts = text.split(" ");
    if (nameparts.isNotEmpty) {
      initials = nameparts[0][0].toUpperCase();
    }
    if (nameparts.length > 1) {
      initials += nameparts[1][0].toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kButtonColor,
      child: Text(
        initials,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
