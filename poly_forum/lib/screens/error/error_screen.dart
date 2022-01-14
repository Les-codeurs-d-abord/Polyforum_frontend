import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String imageName;

  const ErrorScreen(this.imageName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("images/$imageName"),
    );
  }
}
