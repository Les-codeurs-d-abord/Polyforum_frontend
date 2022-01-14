import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/screens/welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldColor,
      body: Body(),
    );
  }
}
