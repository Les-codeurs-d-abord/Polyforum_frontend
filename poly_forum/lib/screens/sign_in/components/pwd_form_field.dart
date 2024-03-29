import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PwdFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const PwdFormField(this._textEditingController, {Key? key}) : super(key: key);

  @override
  _PwdFormFieldState createState() => _PwdFormFieldState();
}

class _PwdFormFieldState extends State<PwdFormField> {
  bool _obscureText = true;

  _passwordRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final password = prefs.getString(kPwdPref) ?? '';
    widget._textEditingController.text = password;
  }

  @override
  void initState() {
    super.initState();

    _passwordRetriever();
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
        SharedPreferences.getInstance().then((prefs) {
          var isPasswordSaved = prefs.getBool('save_password') ?? false;
          if (isPasswordSaved) {
            SharedPreferences.getInstance()
                .then((prefs) => prefs.setString(kPwdPref, value!));
          }
        });
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
