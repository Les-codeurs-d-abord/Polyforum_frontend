import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class PhaseIndicator extends StatelessWidget {
  const PhaseIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildItem(
          context,
          "1",
          "Inscription",
          const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        const SizedBox(width: 5),
        buildItem(
          context,
          "2",
          "Vœux",
          const BorderRadius.all(Radius.zero),
        ),
        const SizedBox(width: 5),
        buildItem(
          context,
          "3",
          "Planning",
          const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget buildItem(
      BuildContext context, String nb, String text, BorderRadius borderRadius) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border.all(color: Colors.black),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: kButtonColor,
              radius: 20,
              child: Text(
                nb,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
