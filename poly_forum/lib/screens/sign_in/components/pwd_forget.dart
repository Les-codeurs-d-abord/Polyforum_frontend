import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class PwdForget extends StatelessWidget {
  const PwdForget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => print("Mdp oublié"),
      style: TextButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF263238),
              width: 1,
            ),
          ),
        ),
        child: const Text("Mot de passe oublié"),
      ),
    );
  }
}
