import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';

import '../custom_text_field.dart';

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
              Row(
                children: [
                  CustomTextField(
                    text: "Lien",
                    icon: Icons.link_outlined,
                    controller: _linkController,
                    isLocked: false,
                    isLink: true,
                    stringFilters: links,
                  )
                ],
              ),
              const SizedBox(height: 30),
              RowBtn(
                text: "Valider",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, _linkController.text);
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
