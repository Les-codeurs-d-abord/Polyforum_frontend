import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:poly_forum/cubit/candidate/update_candidate_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/profile_links.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/profile_tags.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'custom_drop_zone.dart';
import 'custom_text_field.dart';
import 'editable_avatar.dart';
import 'html_description.dart';

// ignore: must_be_immutable
class ProfilForm extends StatefulWidget {
  CandidateUser user;

  ProfilForm({required this.user, Key? key}) : super(key: key);

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
  // final _descriptionController = TextEditingController();
  final _descriptionController = HtmlEditorController();

  List<String> links = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    // _descriptionController.reloadWeb();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _emailController.text = widget.user.email;
    _phoneNumberController.text = widget.user.phoneNumber;
    _addresController.text = widget.user.address;

    _descriptionController.setText(widget.user.description);
    links = widget.user.links;
    tags = widget.user.tags;
  }

  @override
  Widget build(BuildContext context) {
    _descriptionController.setText(widget.user.description);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EditableAvatar(widget.user.firstName + " " + widget.user.lastName),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                  text: "Prénom",
                  icon: Icons.person_outline,
                  controller: _firstNameController),
              const SizedBox(width: 100),
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
              const SizedBox(width: 100),
              CustomTextField(
                text: "Numéro de téléphone",
                icon: Icons.phone_outlined,
                controller: _phoneNumberController,
                isLocked: false,
                maxCharacters: 10,
                minCharacters: 10,
                isNumeric: true,
              ),
              // CustomTextField(
              //     text: "Mot de passe",
              //     icon: Icons.password_outlined,
              //     controller: _passwordController),
            ],
          ),
          // const SizedBox(height: 15),
          // Row(
          //   children: [
          //     CustomTextField(
          //       text: "Numéro de téléphone",
          //       icon: Icons.phone_outlined,
          //       controller: _phoneNumberController,
          //       isLocked: false,
          //       maxCharacters: 10,
          //       minCharacters: 10,
          //       isNumeric: true,
          //     ),
          //     const SizedBox(width: 40),
          //     CustomTextField(
          //       text: "Code Postal",
          //       icon: Icons.location_on_outlined,
          //       controller: _addresController,
          //       isObligatory: false,
          //       isLocked: false,
          //       maxCharacters: 6,
          //       minCharacters: 5,
          //       isNumeric: true,
          //     ),
          //   ],
          // ),
          const SizedBox(height: 15),
          const CustomDropZone(),
          const SizedBox(height: 15),
          HTMLDescription(descriptionController: _descriptionController),
          Row(
            children: [
              // CustomTextField(
              //   text: "Courte présentation",
              //   icon: Icons.article_outlined,
              //   controller: _descriptionController,
              //   isLocked: false,
              //   maxCharacters: 500,
              //   maxLines: 10,
              // ),
            ],
          ),
          const SizedBox(height: 15),
          IntrinsicHeight(
            child: Row(
              children: [
                ProfileTags(tags: tags),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: VerticalDivider(color: Colors.black, thickness: 1),
                ),
                ProfileLinks(links: links),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String description =
                            await _descriptionController.getText();

                        CandidateUser updatedUser = CandidateUser(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          address: _addresController.text,
                          description: description,
                          id: widget.user.id,
                          email: _emailController.text,
                          role: widget.user.role,
                          links: links,
                          tags: tags,
                          logo: widget.user.logo,
                          status: widget.user.status,
                        );

                        BlocProvider.of<UpdateCandidateCubit>(context)
                            .updateUserEvent(updatedUser);
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kButtonColor,
                      onSurface: Colors.grey,
                    ),
                    child: BlocConsumer<UpdateCandidateCubit,
                        UpdateCandidateState>(
                      listener: (context, state) {
                        if (state is UpdateCandidateLoaded) {
                          widget.user = state.user;
                          showTopSnackBar(
                            context,
                            const Padding(
                              padding: EdgeInsets.only(left: 300, right: 10),
                              child: CustomSnackBar.success(
                                message: "Sauvegarde effectuée avec succès !",
                              ),
                            ),
                          );
                        } else if (state is UpdateCandidateError) {
                          showTopSnackBar(
                            context,
                            const Padding(
                              padding: EdgeInsets.only(left: 300, right: 10),
                              child: CustomSnackBar.error(
                                message:
                                    "Un problème est survenue, la sauvegarde ne s'est pas effectuée...",
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateCandidateLoading) {
                          return const CircularProgressIndicator();
                        }
                        return const Text(
                          "Sauvegarder",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}