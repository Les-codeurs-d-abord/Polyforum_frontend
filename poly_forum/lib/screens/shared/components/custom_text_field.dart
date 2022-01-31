import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  final bool isLocked;
  final bool isObligatory;
  final bool isNumeric;
  final bool isLink;
  final List<String> stringFilters;
  final int maxCharacters;
  final int minCharacters;
  final int maxLines;
  final bool isPassword;
  final String? Function(String)? validator;

  const CustomTextField({
    required this.text,
    required this.icon,
    required this.controller,
    this.isLocked = true,
    this.isObligatory = true,
    this.isNumeric = false,
    this.isLink = false,
    this.stringFilters = const [],
    this.maxCharacters = 255,
    this.minCharacters = 0,
    this.maxLines = 1,
    this.isPassword = false,
    this.validator,
    Key? key
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon),
              const SizedBox(width: 5),
              Expanded(
                child: widget.isObligatory
                    ? RichText(
                  text: TextSpan(
                    text: widget.text,
                    children: const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
                    : Text(widget.text),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.controller,
            enabled: !widget.isLocked,
            keyboardType: widget.isNumeric
                ? TextInputType.number
                : widget.maxLines > 1
                ? TextInputType.multiline
                : TextInputType.none,
            inputFormatters:
            widget.isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
            maxLength: widget.maxCharacters,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: widget.maxLines,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              fillColor: widget.isLocked ? Colors.grey[300] : Colors.white,
              filled: true,
              suffixIcon: widget.isPassword ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ) : null,
            ),
            validator: (value) => validateField(value!),
          ),
        ],
      ),
    );
  }

  String? validateField(String value) {
    if (widget.isObligatory && value.isEmpty) {
      return "* Champs Requis";
    }

    if (value.length > widget.maxCharacters) {
      return "Il y a trop de caractères (${value.length - widget.maxCharacters} en trop)";
    }

    if (value.isNotEmpty && value.length < widget.minCharacters) {
      return "Ce champs nécessite au moins ${widget.minCharacters} caractères";
    }

    if (widget.isLink) {
      if (!Uri.parse(value).isAbsolute) {
        return "Le format de l'URL n'est pas valide";
      }
    }

    if (widget.stringFilters.isNotEmpty) {
      if (widget.stringFilters.contains(value)) {
        return "Cette entrée a déjà été enregistré";
      }
    }

    if (widget.validator != null && widget.validator!(value) != null) {
      return widget.validator!(value);
    }

    return null;
  }
}
