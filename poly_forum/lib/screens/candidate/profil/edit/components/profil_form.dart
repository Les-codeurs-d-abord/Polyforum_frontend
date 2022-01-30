import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/update_candidate_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/profile_links.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/profile_tags.dart';
import 'package:poly_forum/screens/shared/components/custom_text_field.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'custom_drop_zone.dart';
import 'editable_avatar.dart';

// ignore: must_be_immutable
class ProfileForm extends StatefulWidget {
  CandidateUser user;

  ProfileForm({required this.user, Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final Phase currentPhase;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addresController = TextEditingController();
  final _descriptionController = TextEditingController();
  // final _descriptionController = HtmlEditorController();

  List<String> links = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();

    // _descriptionController.reloadWeb();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _emailController.text = widget.user.email;
    _phoneNumberController.text = widget.user.phoneNumber;
    _addresController.text = widget.user.address;

    // _descriptionController.setText(widget.user.description);
    _descriptionController.text = widget.user.description;
    links = widget.user.links;
    tags = widget.user.tags;
  }

  @override
  Widget build(BuildContext context) {
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
                isLocked: currentPhase != Phase.inscription,
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
          CustomDropZone(disabled: currentPhase != Phase.inscription),
          const SizedBox(height: 15),
          // HTMLDescription(descriptionController: _descriptionController),
          SizedBox(
            width: 700,
            child: Row(
              children: [
                CustomTextField(
                  text: "Courte présentation",
                  icon: Icons.article_outlined,
                  controller: _descriptionController,
                  isLocked: currentPhase != Phase.inscription,
                  maxCharacters: 500,
                  maxLines: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          IntrinsicHeight(
            child: Row(
              children: [
                ProfileTags(tags: tags, disabled: currentPhase != Phase.inscription),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: VerticalDivider(color: Colors.black, thickness: 1),
                ),
                ProfileLinks(links: links, disabled: currentPhase != Phase.inscription),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: MaterialButton(
                    onPressed: currentPhase != Phase.inscription ? null : () async {
                      if (_formKey.currentState!.validate()) {
                        // String description =
                        //     await _descriptionController.getText();

                        CandidateUser updatedUser = CandidateUser(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          address: _addresController.text,
                          description: _descriptionController.text,
                          id: widget.user.id,
                          candidateId: widget.user.candidateId,
                          email: _emailController.text,
                          role: widget.user.role,
                          links: links,
                          tags: tags,
                          logo: widget.user.logo,
                          status: widget.user.status,
                          wishesCount: widget.user.wishesCount,
                          cv: widget.user.cv
                        );

                        BlocProvider.of<UpdateCandidateCubit>(context)
                            .updateUserEvent(updatedUser);
                      }
                    },
                    textColor: Colors.white,
                    color: kButtonColor,
                    disabledColor: kDisabledButtonColor,
                    child: BlocConsumer<UpdateCandidateCubit,
                        UpdateCandidateState>(
                      listener: (context, state) {
                        if (state is UpdateCandidateLoaded) {
                          widget.user = state.user;
                          showTopSnackBar(
                            context,
                            Padding(
                              padding: kTopSnackBarPadding,
                              child: const CustomSnackBar.success(
                                message: "Sauvegarde effectuée avec succès !",
                              ),
                            ),
                          );
                        } else if (state is UpdateCandidateError) {
                          showTopSnackBar(
                            context,
                            Padding(
                              padding: kTopSnackBarPadding,
                              child: const CustomSnackBar.error(
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
