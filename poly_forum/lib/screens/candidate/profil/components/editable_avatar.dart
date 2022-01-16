import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class EditableAvatar extends StatelessWidget {
  String initials = "";

  EditableAvatar(String text, {Key? key}) : super(key: key) {
    if (text.contains(RegExp(r'[A-Z]'))) {
      var nameparts = text.split(" ");
      if (nameparts.isNotEmpty) {
        initials = nameparts[0][0].toUpperCase();
      }
      if (nameparts.length > 1) {
        initials += nameparts[1][0].toUpperCase();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Positioned.fill(
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                initials,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.edit, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                primary: kButtonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
