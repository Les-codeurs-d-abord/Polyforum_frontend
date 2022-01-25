import 'package:flutter/cupertino.dart';

class LargeDataTile extends StatelessWidget {
  final List<int> values;
  final List<String> texts;
  final Color? color;
  final double valueFontSize;
  final double textFontSize;
  final double width;
  final double height;

  const LargeDataTile({
    Key? key,
    required this.values,
    required this.texts,
    required this.color,
    this.valueFontSize = 20,
    this.textFontSize = 14,
    this.width = 300,
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
        children: values.asMap().keys.map((index) =>
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: values[index].toString(),
                          style: TextStyle(
                            fontSize: valueFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: texts[index],
                          style: TextStyle(
                            fontSize: textFontSize,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ),
        ).toList(),
      ),
    );
  }
}
