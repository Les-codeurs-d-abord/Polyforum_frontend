import 'package:flutter/material.dart';

import 'components/body.dart';

class ChoicesScreen extends StatelessWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: const Body(),
    );
  }
}
