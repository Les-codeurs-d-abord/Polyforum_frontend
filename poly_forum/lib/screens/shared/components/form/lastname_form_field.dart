import 'package:flutter/material.dart';

class LastnameFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const LastnameFormField(this._textEditingController, {Key? key})
      : super(key: key);

  @override
  _LastnameFormFieldState createState() => _LastnameFormFieldState();
}

class _LastnameFormFieldState extends State<LastnameFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        // suffixIcon: Icon(Icons.account_box),
        border: OutlineInputBorder(),
        labelText: 'Nom',
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      keyboardType: TextInputType.name,
      validator: (value) => validateLastname(value!),
      controller: widget._textEditingController,
    );
  }

  String? validateLastname(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    return null;
  }
}
