import 'package:flutter/material.dart';
import 'package:poly_forum/constants.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController _textEditingController;

  const EmailFormField(this._textEditingController, {Key? key})
      : super(key: key);

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  void initState() {
    super.initState();

    // Preferences()
    //     .get("email")
    //     .then((value) => widget.textEditingController.text = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("E-mail", style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.mail),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              if (emailValidatorRegExp.hasMatch(value!)) {
                // Preferences().save("email", value);
              }
            },
            controller: widget._textEditingController,
            validator: (value) {
              if (!emailValidatorRegExp.hasMatch(value!)) {
                return "Veuillez entrer un email valide.";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
