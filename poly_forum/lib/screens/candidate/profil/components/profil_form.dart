import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/components/add_link_modal.dart';
import 'package:poly_forum/screens/candidate/profil/components/custom_text_field.dart';
import 'package:poly_forum/utils/constants.dart';

class ProfilForm extends StatefulWidget {
  const ProfilForm({Key? key}) : super(key: key);

  @override
  _ProfilFormState createState() => _ProfilFormState();
}

class _ProfilFormState extends State<ProfilForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addresController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passwordController = TextEditingController();

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomTextField(text: "Prénom", controller: _firstNameController),
            const SizedBox(width: 40),
            CustomTextField(text: "Nom", controller: _lastNameController)
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CustomTextField(text: "Email", controller: _emailController),
            const SizedBox(width: 40),
            CustomTextField(
                text: "Mot de passe", controller: _passwordController)
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CustomTextField(
              text: "Code Postal",
              controller: _addresController,
              isLocked: false,
              maxCharacters: 6,
              isNumeric: true,
            ),
            const SizedBox(width: 40),
            CustomTextField(
              text: "Numéro de téléphone",
              controller: _phoneNumberController,
              isLocked: false,
              maxCharacters: 10,
              isNumeric: true,
            ),
          ],
        ),
        const SizedBox(height: 15),
        IntrinsicHeight(
          child: Row(
            children: [
              buildTagsPart(),
              const VerticalDivider(color: Colors.black, thickness: 1),
              buildLinksPart(),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            CustomTextField(
              text: "Présentation",
              controller: _descriptionController,
              isLocked: false,
              maxCharacters: 500,
              maxLines: 10,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            buildSaveBtn(),
          ],
        ),
      ],
    );
  }

  Widget buildTagsPart() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tags"),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kButtonColor,
                onSurface: Colors.grey,
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ajouter un Tag",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLinksPart() {
    List<String> links = [];
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Liens"),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kButtonColor,
                onSurface: Colors.grey,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddLinkModal(links: links);
                  },
                ).then((value) {
                  links.add(value);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ajouter un lien",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSaveBtn() {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: kButtonColor,
          onSurface: Colors.grey,
        ),
        onPressed: isLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: isLoading
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sauvegarder",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  String? validateObligatoryField(String value) {
    if (value.isEmpty) {
      return "* Champs Requis";
    }
    if (value.length >= 500) {
      return "Il y a trop de caractères";
    }

    return null;
  }
}
