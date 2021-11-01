import 'package:flutter/material.dart';

class PwdFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const PwdFormField(this._textEditingController, {Key? key}) : super(key: key);

  @override
  _PwdFormFieldState createState() => _PwdFormFieldState();
}

class _PwdFormFieldState extends State<PwdFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Mot de passe", style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            onSaved: null,
            controller: widget._textEditingController,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
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
            ),
            validator: (value) =>
                value!.length < 4 ? "Le mot de passe est trop court." : null,
            obscureText: _obscureText,
          ),
        ),
      ],
    );
  }
}
