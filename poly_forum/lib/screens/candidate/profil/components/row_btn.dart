import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class RowBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double fontSize;

  const RowBtn(
      {required this.text,
      required this.onPressed,
      this.fontSize = 18,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => onPressed(),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: kButtonColor,
              onSurface: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
