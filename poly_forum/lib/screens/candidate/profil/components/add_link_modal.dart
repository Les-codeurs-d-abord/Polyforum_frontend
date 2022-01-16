import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/utils/constants.dart';

class AddLinkModal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();
  final List<String> links;

  AddLinkModal({required this.links, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(30),
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Ajouter un lien",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      controller: _linkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Champs Requis';
                        } else if (!Uri.parse(_linkController.text)
                            .isAbsolute) {
                          return "Le format de l'URL n'est pas valide";
                        } else if (links.contains(_linkController.text)) {
                          return "Cette URL a déjà été enregistré";
                        }

                        return null;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, _linkController.text);
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: kButtonColor,
                        onSurface: Colors.grey,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Valider",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
