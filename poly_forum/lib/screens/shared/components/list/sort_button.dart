import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortButton extends StatefulWidget {
  final String label;
  final void Function(bool) sortCallback;
  bool ascending;

  SortButton({
    Key? key,
    required this.label,
    required this.sortCallback,
    this.ascending = true,
  }) : super(key: key);

  @override
  _SortButtonState createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                ),
                widget.ascending ? const Icon(Icons.arrow_downward) : const Icon(Icons.arrow_upward)
              ],
            ),
            onPressed: () {
              setState(() {
                widget.ascending = !widget.ascending;
              });
              widget.sortCallback(widget.ascending);
            },
          ),
        ]
    );
  }
}
