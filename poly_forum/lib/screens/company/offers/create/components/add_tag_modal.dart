import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';

import '../../../../shared/components/custom_text_field.dart';

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
