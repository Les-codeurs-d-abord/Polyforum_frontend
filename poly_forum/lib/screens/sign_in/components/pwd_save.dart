import 'package:flutter/material.dart';

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
        const Expanded(
          child: Text("Mémoriser votre mot de passe ?"),
        ),
      ],
    );
  }
}
