import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';

class ConfirmationModal extends StatefulWidget {
  final String title;
  final String description;

  const ConfirmationModal({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ConfirmationModal> createState() => _ConfirmationModalState();
}

class _ConfirmationModalState extends State<ConfirmationModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 22
              ),
            ),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  Navigator.of(context).pop(ModalReturn.cancel);
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),
          ]
      ),
      content: SizedBox(
          width: 500,
          child: Text(widget.description)
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      actions: [
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            child: MaterialButton(
              child: const Text(
                "Annuler",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ModalReturn.cancel);
              },
            )
        ),
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: kButtonColor,
            ),
            child: MaterialButton(
              child: const Text(
                "Confirmer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ModalReturn.confirm);
              },
            )
        ),
      ],
    );
  }
}

enum ModalReturn {
  confirm,
  cancel
}
