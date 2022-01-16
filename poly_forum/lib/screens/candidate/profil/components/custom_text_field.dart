import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isLocked;
  final bool isObligatory;
  final bool isNumeric;
  final int maxCharacters;
  final int maxLines;

  const CustomTextField(
      {required this.text,
      required this.controller,
      this.isLocked = true,
      this.isObligatory = true,
      this.isNumeric = false,
      this.maxCharacters = 255,
      this.maxLines = 1,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isObligatory
              ? RichText(
                  text: TextSpan(
                    text: text,
                    children: const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
              : Text(text),
          const SizedBox(height: 10),
          TextFormField(
            enabled: !isLocked,
            keyboardType: isNumeric
                ? TextInputType.number
                : maxLines > 1
                    ? TextInputType.multiline
                    : TextInputType.none,
            inputFormatters:
                isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
            maxLength: maxCharacters,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: maxLines,
            decoration: isLocked
                ? InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    fillColor: Colors.grey[300],
                    filled: true,
                  )
                : const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
            validator: (value) => validateObligatoryField(value!),
          ),
        ],
      ),
    );
  }

  String? validateObligatoryField(String value) {
    if (isObligatory && value.isEmpty) {
      return "* Champs Requis";
    }
    if (value.length >= maxCharacters) {
      return "Il y a trop de caractères (${value.length - maxCharacters} en trop)";
    }

    return null;
  }
}
