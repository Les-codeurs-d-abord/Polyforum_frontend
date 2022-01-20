import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/utils/constants.dart';

class TabNavigationItem extends StatefulWidget {
  Function onPressed;
  final bool isSelect;
  final String text;
  final IconData iconData;

  TabNavigationItem({
    Key? key,
    required this.onPressed,
    required this.isSelect,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  State<TabNavigationItem> createState() => _TabNavigationItemState();
}

class _TabNavigationItemState extends State<TabNavigationItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        isHovering = true;
      }),
      onExit: (event) => setState(() {
        isHovering = false;
      }),
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
        },
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: isHovering | widget.isSelect
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withAlpha(60),
                  )
                : null,
            child: Row(
              children: [
                widget.isSelect
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          color: kButtonColor,
                        ),
                        width: 10,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 10),
                Icon(
                  widget.iconData,
                  color: Colors.white,
                ),
                const SizedBox(width: 15),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        widget.isSelect ? FontWeight.bold : FontWeight.normal,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                widget.isSelect
                    ? Icon(
                        Icons.arrow_right_outlined,
                        color: Colors.white,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
