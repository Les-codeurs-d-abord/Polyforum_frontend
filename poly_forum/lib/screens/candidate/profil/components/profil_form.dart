import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/screens/candidate/profil/components/add_link_modal.dart';
import 'package:poly_forum/screens/candidate/profil/components/custom_text_field.dart';
import 'package:poly_forum/screens/candidate/profil/components/profile_links.dart';
import 'package:poly_forum/screens/candidate/profil/components/profile_tags.dart';
import 'package:poly_forum/screens/candidate/profil/components/row_btn.dart';
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

  List<String> links = [];
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                  text: "Prénom",
                  icon: Icons.person_outline,
                  controller: _firstNameController),
              const SizedBox(width: 40),
              CustomTextField(
                  text: "Nom",
                  icon: Icons.person_outline,
                  controller: _lastNameController)
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomTextField(
                text: "Email",
                icon: Icons.mail_outline,
                controller: _emailController,
              ),
              const SizedBox(width: 40),
              CustomTextField(
                  text: "Mot de passe",
                  icon: Icons.password_outlined,
                  controller: _passwordController),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomTextField(
                text: "Code Postal",
                icon: Icons.location_on_outlined,
                controller: _addresController,
                isLocked: false,
                maxCharacters: 6,
                minCharacters: 5,
                isNumeric: true,
              ),
              const SizedBox(width: 40),
              CustomTextField(
                text: "Numéro de téléphone",
                icon: Icons.phone_outlined,
                controller: _phoneNumberController,
                isLocked: false,
                maxCharacters: 10,
                minCharacters: 10,
                isNumeric: true,
              ),
            ],
          ),
          const SizedBox(height: 15),
          IntrinsicHeight(
            child: Row(
              children: [
                ProfileTags(tags: tags),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      const VerticalDivider(color: Colors.black, thickness: 1),
                ),
                ProfileLinks(links: links),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CustomTextField(
                text: "Présentation",
                icon: Icons.article_outlined,
                controller: _descriptionController,
                isLocked: false,
                maxCharacters: 500,
                maxLines: 10,
              ),
            ],
          ),
          const SizedBox(height: 30),
          RowBtn(
            text: "Sauvegarder",
            fontSize: 20,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(links);
              }
            },
          ),
        ],
      ),
    );
  }
}
