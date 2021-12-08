import 'package:flutter/material.dart';

class CompanyFormDialog extends StatelessWidget {
  const CompanyFormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
          children: [
            const Text("Gimme me gimme now"),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),
          ]
      ),
      content: Container(
          width: 700,
          height: 500,
          child: Text("Tch tch tch tch")
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          child: const Text("Hmmmmmmm, every body look at me"),
          onPressed: () {
          },
        ),
        TextButton(
          child: const Text("Ixu kadjani ;)"),
          onPressed: () {
          },
        )
      ],
    );
  }
}
