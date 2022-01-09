import 'package:flutter/material.dart';

class CompanyNameFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const CompanyNameFormField(this._textEditingController, {Key? key})
      : super(key: key);

  @override
  _CompanyNameFormFieldState createState() => _CompanyNameFormFieldState();
}

class _CompanyNameFormFieldState extends State<CompanyNameFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.home),
        border: OutlineInputBorder(),
        labelText: 'Raison sociale',
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      keyboardType: TextInputType.name,
      validator: (value) => validateCompanyName(value!),
      controller: widget._textEditingController,
    );
  }

  String? validateCompanyName(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    return null;
  }
}
