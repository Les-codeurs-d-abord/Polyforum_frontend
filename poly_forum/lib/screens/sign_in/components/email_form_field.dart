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
    return TextFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.mail),
        border: OutlineInputBorder(),
        // hintText: "Email",
        labelText: 'Email',
        // hintStyle: TextStyle(
        //   fontSize: 20,
        //   // color: kPrimaryColor,
        // ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 25,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validateEmail(value!),
      controller: widget._textEditingController,
      onSaved: (value) {
        print("save email");
        if (emailValidatorRegExp.hasMatch(value!)) {
          // Preferences().save("email", value);
        }
      },
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

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("E-mail", style: Theme.of(context).textTheme.headline6),
  //       const SizedBox(height: 10),
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(0),
  //           border: Border.all(color: Colors.grey),
  //         ),
  //         child: TextFormField(
  //           decoration: InputDecoration(
  //             enabledBorder: OutlineInputBorder(),
  //             suffixIcon: Icon(Icons.mail),
  //             border: InputBorder.none,
  //             hintText: "Email",
  //             hintStyle: TextStyle(
  //               fontSize: 20,
  //               // color: kPrimaryColor,
  //             ),
  //           ),
  //           style: const TextStyle(
  //             fontWeight: FontWeight.normal,
  //             fontSize: 25,
  //           ),
  //           keyboardType: TextInputType.emailAddress,
  //           onSaved: (value) {
  //             if (emailValidatorRegExp.hasMatch(value!)) {
  //               // Preferences().save("email", value);
  //             }
  //           },
  //           controller: widget._textEditingController,
  //           validator: (value) {
  //             if (!emailValidatorRegExp.hasMatch(value!)) {
  //               return "Veuillez entrer un email valide.";
  //             }
  //             return null;
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
