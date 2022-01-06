import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const EmailFormField(this._textEditingController, {Key? key}) : super(key: key);

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validateEmail(value!),
      controller: widget._textEditingController,
    );
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    if (!emailValidatorRegExp.hasMatch(value)) {
      return "Veuillez entrer un email valide.";
    }
    return null;
  }
}
