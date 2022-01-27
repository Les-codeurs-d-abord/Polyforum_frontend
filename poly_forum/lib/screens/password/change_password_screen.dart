import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/custom_text_field.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordFirstController = TextEditingController();
  final _newPasswordSecondController = TextEditingController();

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              CustomTextField(
                text: "Mot de passe actuel",
                icon: Icons.article_outlined,
                controller: _currentPasswordController,
                maxCharacters: 50,
                isLocked: false,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomTextField(
                text: "Nouveau mot de passe",
                icon: Icons.article_outlined,
                controller: _currentPasswordController,
                maxCharacters: 50,
                isLocked: false,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomTextField(
                text: "Confirmer le nouveau mot de passe",
                icon: Icons.article_outlined,
                controller: _currentPasswordController,
                maxCharacters: 50,
                isLocked: false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          RowBtn(text: "Valider", onPressed: () {}),
        ],
      ),
    );

    return BaseScreen(
      child: child,
      width: 500,
    );
  }
}
