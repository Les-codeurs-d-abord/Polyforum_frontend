import 'package:flutter/material.dart';

class TagsDropDownBtn extends StatefulWidget {
  const TagsDropDownBtn({Key? key}) : super(key: key);

  @override
  _TagsDropDownBtnState createState() => _TagsDropDownBtnState();
}

class _TagsDropDownBtnState extends State<TagsDropDownBtn> {
  String dropdownValue = "Tags";

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black,
          ),
          underline: const SizedBox(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
          hint: const Text("Tags"),
          items: <String>["Tags", "Flutter", "C++", "C#", "Java", "etc"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
        ),
      ),
    );
  }
}
