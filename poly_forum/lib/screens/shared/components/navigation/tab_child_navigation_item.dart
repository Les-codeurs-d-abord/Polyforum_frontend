import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabChildNavigationItem extends StatelessWidget {
  final Function? onPressed;
  final int index;
  final int selectedIndex;
  final String text;

  const TabChildNavigationItem(
      {required this.onPressed,
      required this.index,
      required this.selectedIndex,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: onPressed != null
            ? () {
                onPressed!();
                if (!kIsWebVersion) Navigator.of(context).pop();
              }
            : null,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? kButtonColor : Colors.transparent,
              radius: 5,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: onPressed != null
                    ? TextStyle(
                        color: Colors.white,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 18,
                      )
                    : const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
