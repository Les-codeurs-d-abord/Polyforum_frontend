import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';

import 'body.dart';

class CandidatList extends StatelessWidget {
  const CandidatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      child: Body(),
      width: 1600,
    );
  }
}
