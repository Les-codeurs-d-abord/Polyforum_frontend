import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class HomePage extends StatelessWidget {
  final Widget child;

  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      backgroundColor: kScaffoldColor,
    );
  }
}
