import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/utils/constants.dart';

// ignore: must_be_immutable
class TabNavigationItem extends StatefulWidget {
  final List<TabChildNavigationItem> children;
  Function? onPressed;
  final int index;
  final int selectedIndex;
  final IconData iconSelected;
  final IconData iconNonSelected;
  final String text;
  final bool isEnable;
  final String messageToolTipOnLock;

  TabNavigationItem(
      {Key? key,
      required this.onPressed,
      required this.index,
      required this.selectedIndex,
      required this.text,
      required this.iconSelected,
      required this.iconNonSelected,
      this.children = const [],
      this.isEnable = true,
      this.messageToolTipOnLock = "Cet onglet n'est pas encore valide."})
      : super(key: key);

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
              onTap: widget.onPressed != null && widget.isEnable
                  ? () {
                      widget.onPressed!();
                      if (!kIsWebVersion) Navigator.of(context).pop();
                    }
                  : null,
              child: Container(
                height: 60,
                decoration: (isHovering | isSelected) && widget.isEnable
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
                      color: widget.isEnable
                          ? Colors.white
                          : Colors.white.withAlpha(150),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.isEnable
                            ? Colors.white
                            : Colors.white.withAlpha(150),
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    !widget.isEnable
                        ? Tooltip(
                            message: widget.messageToolTipOnLock,
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lock,
                                  color: Colors.white.withAlpha(200),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.help,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ],
                            ),
                          )
                        : widget.children.isEmpty
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
