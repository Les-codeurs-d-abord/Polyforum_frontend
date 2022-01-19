import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String) searchCallback;

  const SearchBar({
    Key? key,
    required this.searchCallback
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String currentInput = '';

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Flexible(
            child: TextField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search, size: 30),
                border: OutlineInputBorder(),
                labelText: "Rechercher...",
              ),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
              onChanged: (value) {
                currentInput = value;
                widget.searchCallback(currentInput);
              },
              onSubmitted: (value) {
                widget.searchCallback(currentInput);
              },
            ),
          ),
        ]
    );
  }
}
