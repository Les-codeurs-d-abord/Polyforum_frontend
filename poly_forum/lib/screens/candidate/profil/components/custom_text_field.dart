import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  final bool isLocked;
  final bool isObligatory;
  final bool isNumeric;
  final List<String> urls;
  final int maxCharacters;
  final int minCharacters;
  final int maxLines;

  const CustomTextField(
      {required this.text,
      required this.icon,
      required this.controller,
      this.isLocked = true,
      this.isObligatory = true,
      this.isNumeric = false,
      this.urls = const [],
      this.maxCharacters = 255,
      this.minCharacters = 0,
      this.maxLines = 1,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 5),
              Expanded(
                child: isObligatory
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
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
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
            validator: (value) => validateField(value!),
          ),
        ],
      ),
    );
  }

  String? validateField(String value) {
    if (isObligatory && value.isEmpty) {
      return "* Champs Requis";
    }
    if (value.length > maxCharacters) {
      return "Il y a trop de caractères (${value.length - maxCharacters} en trop)";
    }
    if (value.length < minCharacters) {
      return "Ce champs nécessite au moins $minCharacters caractères";
    }

    if (urls.isNotEmpty) {
      if (!Uri.parse(value).isAbsolute) {
        return "Le format de l'URL n'est pas valide";
      } else if (urls.contains(value)) {
        return "Cette URL a déjà été enregistré";
      }
    }

    return null;
  }
}
