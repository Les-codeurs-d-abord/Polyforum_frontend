import 'package:flutter/cupertino.dart';

class DataTile extends StatelessWidget {
  final int value;
  final String text;
  final Color? color;
  final double valueFontSize;
  final double textFontSize;
  final double width;
  final double height;

  const DataTile({
    Key? key,
    required this.value,
    required this.text,
    required this.color,
    this.valueFontSize = 40,
    this.textFontSize = 14,
    this.width = 150,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                value.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: valueFontSize,
                ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                ),
            ),
          ],
        ),
    );
  }
}
