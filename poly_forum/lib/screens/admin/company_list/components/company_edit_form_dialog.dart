import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/screens/shared/components/form/email_form_field.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/utils/constants.dart';

class CompanyEditFormDialog extends StatefulWidget {
  final Company company;

  const CompanyEditFormDialog(this.company, {Key? key}) : super(key: key);

  @override
  _CompanyEditFormDialogState createState() => _CompanyEditFormDialogState();
}

class _CompanyEditFormDialogState extends State<CompanyEditFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController(text: widget.company.email);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyFormCubit, CompanyFormState>(
        listener: (context, state) {
          if (state is CompanyFormLoaded) {
            Navigator.of(context).pop(ModalReturn.confirm);
          }
        },
        builder: (context, state) {
          if (state is CompanyFormLoading) {
            return buildCompanyFormDialog(context, true);
          } else if (state is CompanyFormError) {
            return buildCompanyFormDialog(context, false, state.errorMessage);
          } else {
            return buildCompanyFormDialog(context);
          }
        }
    );
  }

  buildCompanyFormDialog(BuildContext context, [bool isLoading = false, String error = '']) {
    return AlertDialog(
      title: Stack(
          children: [
            const Text(
              "Modifier une entreprise",
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
          child: Wrap(
            children: [
              EmailFormField(_emailController),
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
              onPressed: isLoading ?
              null : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  BlocProvider.of<CompanyFormCubit>(context).editCompany(widget.company, _emailController.text);
                }
              },
            )
        ),
      ],
    );
  }
}
