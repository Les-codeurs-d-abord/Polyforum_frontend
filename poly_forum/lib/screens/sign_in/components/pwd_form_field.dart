import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PwdFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const PwdFormField(this._textEditingController, {Key? key}) : super(key: key);

  @override
  _PwdFormFieldState createState() => _PwdFormFieldState();
}

class _PwdFormFieldState extends State<PwdFormField> {
  bool _obscureText = true;
  bool _isPasswordSaved = false;

  _passwordRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final password = prefs.getString('password') ?? '';
    widget._textEditingController.text = password;
  }

  _savedPasswordRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPasswordSaved = prefs.getBool('save_password') ?? false;
  }

  @override
  void initState() {
    super.initState();

    _passwordRetriever();
    _savedPasswordRetriever();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: const OutlineInputBorder(),
        labelText: "Mot de passe",
      ),
      obscureText: _obscureText,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 25,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validatePasswordl(value!),
      controller: widget._textEditingController,
      onSaved: (value) {
        if (_isPasswordSaved) {
          SharedPreferences.getInstance()
              .then((prefs) => prefs.setString('password', value!));
        }
      },
    );
  }

  String? validatePasswordl(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    if (value.length < 4) {
      return "Le mot de passe est trop court.";
    }

    return null;
  }
}
