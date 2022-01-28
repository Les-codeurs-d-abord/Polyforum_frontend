import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class TabNavigationItem extends StatefulWidget {
  final List<TabChildNavigationItem> children;
  Function onPressed;
  final int index;
  final int selectedIndex;
  final IconData iconSelected;
  final IconData iconNonSelected;
  final String text;

  TabNavigationItem({
    Key? key,
    required this.onPressed,
    required this.index,
    required this.selectedIndex,
    required this.text,
    required this.iconSelected,
    required this.iconNonSelected,
    this.children = const [],
  }) : super(key: key);

  @override
  State<TabNavigationItem> createState() => _TabNavigationItemState();
}

class _TabNavigationItemState extends State<TabNavigationItem> {
  bool isHovering = false;
  List<int> indexList = [];

  @override
  void initState() {
    super.initState();
    indexList.add(widget.index);

    for (var child in widget.children) {
      indexList.add(child.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = indexList.contains(widget.selectedIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
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
                decoration: isHovering | isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withAlpha(60),
                      )
                    : null,
                child: Row(
                  children: [
                    isSelected
                        ? Container(
                            decoration: const BoxDecoration(
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
                      isSelected ? widget.iconSelected : widget.iconNonSelected,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    widget.children.isEmpty
                        ? isSelected
                            ? const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.white,
                              )
                            : const SizedBox.shrink()
                        : isSelected
                            ? const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                  ],
                ),
              ),
            ),
          ),
          isSelected
              ? Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.children,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
