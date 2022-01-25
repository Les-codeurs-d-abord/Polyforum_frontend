import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class TabChildNavigationItem extends StatelessWidget {
  final String title;
  final Function onPress;
  final bool isSelect;

  const TabChildNavigationItem(
      {required this.title,
      required this.onPress,
      required this.isSelect,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: () => onPress(),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelect ? kButtonColor : Colors.transparent,
              radius: 5,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isSelect ? FontWeight.bold : FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
