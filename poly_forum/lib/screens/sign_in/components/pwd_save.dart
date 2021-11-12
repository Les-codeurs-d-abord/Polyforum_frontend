import 'package:flutter/material.dart';
import 'package:poly_forum/constants.dart';

class PwdSave extends StatefulWidget {
  const PwdSave({Key? key}) : super(key: key);

  @override
  _PwdSaveState createState() => _PwdSaveState();
}

class _PwdSaveState extends State<PwdSave> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Expanded(
          child: const Text(
            "Rester connecté",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
