import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class Tags extends StatelessWidget {
  final String text;

  const Tags({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kButtonColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
        ),
      ),
      // child: Tags(
      //   text: localOfferList[i].tags[index],
      // ),
    );
  }
}
