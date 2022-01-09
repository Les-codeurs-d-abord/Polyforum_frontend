import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/screens/shared/components/form/email_form_field.dart';
import 'package:poly_forum/screens/shared/components/form/firstname_form_field.dart';
import 'package:poly_forum/screens/shared/components/form/lastname_form_field.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateFormDialog extends StatefulWidget {
  const CandidateFormDialog({Key? key}) : super(key: key);

  @override
  _CandidateFormDialogState createState() => _CandidateFormDialogState();
}

class _CandidateFormDialogState extends State<CandidateFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateFormCubit, CandidateFormState>(
        listener: (context, state) {
          if (state is CandidateFormLoaded) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is CandidateFormLoading) {
            return buildCandidateFormDialog(context, true);
          } else if (state is CandidateFormError) {
            return buildCandidateFormDialog(context, false, state.errorMessage);
          } else {
            return buildCandidateFormDialog(context);
          }
        }
    );
  }

  buildCandidateFormDialog(BuildContext context, [bool isLoading = false, String error = '']) {
    return AlertDialog(
      title: Stack(
          children: [
            const Text(
              "Ajouter un candidat",
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  isLoading ? null : Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),
          ]
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 500,
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: EmailFormField(_emailController),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: LastNameFormField(_lastNameController),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child:FirstNameFormField(_firstNameController),
                  ),
                ],
              ),
              if (error.isNotEmpty)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    error,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18
                    ),
                  ),
                )
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
                isLoading ? null : Navigator.of(context).pop();
              },
            )
        ),
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: kOrange,
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
              onPressed: isLoading ?
              null : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<CandidateFormCubit>(context)
                      .createCandidate(_emailController.text, _lastNameController.text, _firstNameController.text);
                }
              },
            )
        ),
      ],
    );
  }
}
