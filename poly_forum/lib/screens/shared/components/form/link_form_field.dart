import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class LinkFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const LinkFormField(this._textEditingController, {Key? key}) : super(key: key);

  @override
  _LinkFormFieldState createState() => _LinkFormFieldState();
}

class _LinkFormFieldState extends State<LinkFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.link),
        border: OutlineInputBorder(),
        labelText: 'Lien',
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      keyboardType: TextInputType.url,
      validator: (value) => validateLink(value!),
      controller: widget._textEditingController,
    );
  }

  String? validateLink(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    if (!linkValidatorRegExp.hasMatch(value)) {
      return "Veuillez entrer un lien valide.";
    }
    return null;
  }
}
