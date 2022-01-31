import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class RowBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double fontSize;
  final Color color;
  final bool isLoading;
  final bool isDisabled;

  const RowBtn({
    required this.text,
    required this.onPressed,
    this.color = kButtonColor,
    this.fontSize = 18,
    this.isLoading = false,
    this.isDisabled = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: isDisabled ? null : onPressed,
            textColor: Colors.white,
            color: color,
            disabledColor: isDisabled ? kDisabledButtonColor : color,
            child: SizedBox(
              height: 50,
              child: Center(
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
        ),
      ],
    );
  }
}
