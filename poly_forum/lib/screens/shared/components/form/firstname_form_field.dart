import 'package:flutter/material.dart';

class FirstNameFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const FirstNameFormField(this._textEditingController, {Key? key})
      : super(key: key);

  @override
  _FirstNameFormFieldState createState() => _FirstNameFormFieldState();
}

class _FirstNameFormFieldState extends State<FirstNameFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.account_box),
        border: OutlineInputBorder(),
        labelText: 'Prénom',
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      keyboardType: TextInputType.name,
      validator: (value) => validateFirstname(value!),
      controller: widget._textEditingController,
    );
  }

  String? validateFirstname(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    return null;
  }
}
