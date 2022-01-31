import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/pwd_forget_form_cubit.dart';
import 'package:poly_forum/screens/shared/components/form/email_form_field.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PwdForgetForm extends StatefulWidget {
  const PwdForgetForm({Key? key}) : super(key: key);

  @override
  _PwdForgetFormState createState() => _PwdForgetFormState();
}

class _PwdForgetFormState extends State<PwdForgetForm> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PwdForgetFormCubit, PwdForgetFormState>(
        listener: (context, state) {
          if (state is PwdForgetFormLoaded) {
            showTopSnackBar(
              context,
              const CustomSnackBar.success(
                message: "Un mail vient de vous être envoyé",
              ),
            );
            Navigator.of(context).pop(ModalReturn.confirm);
          } else if (state is PwdForgetFormError) {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: state.errorMessage,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PwdForgetFormLoading) {
            return buildPwdForgetFormDialog(context, isLoading: true);
          } else {
            return buildPwdForgetFormDialog(context);
          }
        }
    );
  }

  buildPwdForgetFormDialog(BuildContext context, {bool isLoading = false}) {
    return AlertDialog(
      title: Stack(
          children: [
            const Text(
              "Mot de passe oublié",
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  isLoading ? null : Navigator.of(context).pop(ModalReturn.cancel);
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),
          ]
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                    "Veuillez saisir l'adresse mail de votre compte.\n"
                        "Un mail vous y sera envoyé pour vous permettre de vous connecter à nouveau.",
                  textAlign: TextAlign.justify,
                ),
              ),
              EmailFormField(_emailController),
            ],
          ),
        ),
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
                isLoading ? null : Navigator.of(context).pop(ModalReturn.cancel);
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
              child:
              isLoading ?
              const SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                width: 15,
                height: 15,
              ) :
              const Text(
                "Valider",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: isLoading ? null : () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<PwdForgetFormCubit>(context).resetForgottenPassword(_emailController.text);
                }
              },
            )
        ),
      ],
    );
  }
}
