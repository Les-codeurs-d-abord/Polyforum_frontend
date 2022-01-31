import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/company_profile_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/shared/components/custom_text_field.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/profile/editable_avatar.dart';
import 'package:poly_forum/screens/shared/components/profile/profile_links.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addresController = TextEditingController();

  List<String> links = [];
  List<String> tags = [];

  late Phase currentPhase;
  late CompanyUser user;

  @override
  void initState() {
    super.initState();

    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
    user = BlocProvider.of<CompanyGetUserCubit>(context).getUser();

    _nameController.text = user.companyName;
    _emailController.text = user.email;
    _phoneNumberController.text = user.phoneNumber;

    _descriptionController.text = user.description;
    links = user.links;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
      listener: (context, state) {
        if (state is CompanyProfileLoaded) {
          BlocProvider.of<CompanyGetUserCubit>(context).setUser(user);

          // BlocProvider.of<CompanyGetOfferCubit>(context).getOfferList(user);

          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "Sauvegarde effectuée avec succès !",
              ),
            ),
          );
        } else if (state is CompanyProfileError) {
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
        return Form(
          key: _formKey,
          child: Column(
            children: [
              EditableAvatar(
                name: user.companyName,
                user: user,
                uri: user.logo,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomTextField(
                    text: "Nom",
                    icon: Icons.person_outline,
                    controller: _nameController,
                    isLocked: true,
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
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  CustomTextField(
                    text: "Email",
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    isLocked: true,
                  ),
                  const SizedBox(width: 100),
                  ProfileLinks(
                      links: links,
                      disabled: currentPhase != Phase.inscription),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 700,
                child: Row(
                  children: [
                    CustomTextField(
                      text: "Courte présentation",
                      textAlign: TextAlign.justify,
                      icon: Icons.article_outlined,
                      controller: _descriptionController,
                      isLocked: currentPhase != Phase.inscription,
                      maxCharacters: 500,
                      maxLines: 10,
                    ),
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
                        onPressed: currentPhase != Phase.inscription
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  user.description =
                                      _descriptionController.text;
                                  user.phoneNumber =
                                      _phoneNumberController.text;
                                  user.links = links;

                                  BlocProvider.of<CompanyProfileCubit>(context)
                                      .updateCompany(user);
                                }
                              },
                        textColor: Colors.white,
                        color: kButtonColor,
                        disabledColor: kDisabledButtonColor,
                        child: BlocConsumer<CompanyProfileCubit,
                            CompanyProfileState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is CompanyProfileError) {
                              return const CircularProgressIndicator();
                            } else if (state is CompanyProfileLoading) {
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
      },
    );
  }
}
