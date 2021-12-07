import 'package:flutter/material.dart';
import 'package:poly_forum/constants.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/Home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const Scaffold(
          backgroundColor: kScaffoldColor,
        ),
        onWillPop: () async => true);
  }
}
