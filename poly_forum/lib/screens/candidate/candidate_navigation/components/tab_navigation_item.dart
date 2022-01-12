import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/utils/constants.dart';

class TabNavigationItem extends StatelessWidget {
  Function onPressed;
  final bool isSelect;
  final String text;

  TabNavigationItem({
    Key? key,
    required this.onPressed,
    required this.isSelect,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            const Spacer(),
            Text(
              text,
              style: TextStyle(
                color: isSelect ? Colors.black : Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const Spacer(),
            isSelect
                ? Container(
                    height: 5,
                    width: double.infinity,
                    color: kButtonColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
