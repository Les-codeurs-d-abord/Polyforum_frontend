import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class RowBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;
  final Color color;
  final bool isLoading;

  const RowBtn(
      {required this.text,
      required this.onPressed,
      this.color = kButtonColor,
      this.fontSize = 18,
      this.isLoading = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: color,
                onSurface: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: !isLoading
                    ? Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: fontSize,
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
