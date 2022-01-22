import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/components/row_btn.dart';

import 'custom_text_field.dart';

class AddTagModal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tagController = TextEditingController();
  final List<String> tags;

  AddTagModal({required this.tags, Key? key}) : super(key: key);

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
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CustomTextField(
                    text: "Tag",
                    icon: Icons.link_outlined,
                    controller: _tagController,
                    isLocked: false,
                    stringFilters: tags,
                    maxCharacters: 20,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              RowBtn(
                text: "Valider",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, _tagController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class AddTagModal extends StatelessWidget {
  final List<Tag> tags;

  AddTagModal({required this.tags, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: 600,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Tags existant"),
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: kButtonColor,
                                          onSurface: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text("test"),
                                        onPressed: () => {},
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Mes tags"),
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 15,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor: Colors.blue,
                                                onSurface: Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: Text("test"),
                                              onPressed: () => {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: RowBtn(
                                  text: "Créer un tag",
                                  onPressed: () => print("oui"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              RowBtn(
                text: "Valider",
                onPressed: () => print("oui"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */