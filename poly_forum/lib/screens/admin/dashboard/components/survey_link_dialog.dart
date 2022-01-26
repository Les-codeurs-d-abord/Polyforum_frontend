import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/form/form_return_enum.dart';
import 'package:poly_forum/screens/shared/components/form/link_form_field.dart';
import 'package:poly_forum/utils/constants.dart';

class SurveyLinkDialog extends StatefulWidget {
  final TextEditingController _surveyLinkController;

  const SurveyLinkDialog(this._surveyLinkController, {Key? key}) : super(key: key);

  @override
  State<SurveyLinkDialog> createState() => _SurveyLinkDialogState();
}

class _SurveyLinkDialogState extends State<SurveyLinkDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
          children: [
            const Text(
              "Envoyer un questionnaire de satisfaction",
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  Navigator.of(context).pop(FormReturn.cancel);
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: LinkFormField(widget._surveyLinkController),
              ),
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
                Navigator.of(context).pop(FormReturn.cancel);
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
                "Valider",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop(FormReturn.confirm);
                }
              },
            )
        ),
      ],
    );
  }
}
