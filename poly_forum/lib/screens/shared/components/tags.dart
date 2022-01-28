import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class Tags extends StatelessWidget {
  final String text;

  const Tags({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kSecondaryColor.withAlpha(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: kButtonColor, fontSize: 15,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      // child: Tags(
      //   text: localOfferList[i].tags[index],
      // ),
    );
  }
}
