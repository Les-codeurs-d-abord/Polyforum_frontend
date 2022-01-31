import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/password/change_password_cubit.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/custom_text_field.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final User user;

  final _currentPasswordController = TextEditingController();
  final _newPasswordFirstController = TextEditingController();
  final _newPasswordSecondController = TextEditingController();

  Body(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordLoaded) {
            showTopSnackBar(
              context,
              Padding(
                padding: kTopSnackBarPadding,
                child: const CustomSnackBar.success(
                  message:
                  "Le changement de votre mot de passe a bien été effectué.",
                ),
              ),
            );
          } else if (state is ChangePasswordError) {
            showTopSnackBar(
              context,
              Padding(
                padding: kTopSnackBarPadding,
                child: CustomSnackBar.error(
                  message: state.errorMessage,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChangePasswordLoading) {
            return buildChangePasswordForm(context, isLoading: true);
          } else {
            return buildChangePasswordForm(context);
          }
        }
    );

    return BaseScreen(
      child: child,
      width: 500,
    );
  }

  Widget buildChangePasswordForm(BuildContext context, {bool isLoading = false}) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              CustomTextField(
                text: "Mot de passe actuel",
                icon: Icons.article_outlined,
                controller: _currentPasswordController,
                isObligatory: true,
                maxCharacters: kPasswordMaxLength,
                isLocked: false,
                isPassword: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomTextField(
                text: "Nouveau mot de passe",
                icon: Icons.article_outlined,
                controller: _newPasswordFirstController,
                isObligatory: true,
                maxCharacters: kPasswordMaxLength,
                isLocked: false,
                isPassword: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomTextField(
                text: "Confirmer le nouveau mot de passe",
                icon: Icons.article_outlined,
                controller: _newPasswordSecondController,
                isObligatory: true,
                maxCharacters: kPasswordMaxLength,
                isLocked: false,
                isPassword: true,
                validator: (secondPassword) {
                  if (secondPassword.isNotEmpty && secondPassword != _newPasswordFirstController.text) {
                    return "Les nouveaux mots de passe ne correspondent pas";
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          RowBtn(
              text: "Valider",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<ChangePasswordCubit>(context)
                      .changePassword(user, _currentPasswordController.text, _newPasswordFirstController.text);
                }
              }
          ),
        ],
      ),
    );
  }
}
