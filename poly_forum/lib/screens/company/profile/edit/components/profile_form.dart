import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/company_profile_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/custom_text_field.dart';
import 'package:poly_forum/screens/shared/components/profile/profile_links.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late CompanyUser companyUser;

  @override
  void initState() {
    super.initState();

    companyUser = BlocProvider.of<CompanyGetUserCubit>(context).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
      listener: (context, state) {
        if (state is CompanyProfileLoaded) {
          _nameController.clear();
          _descriptionController.clear();
          _phoneNumberController.clear();
          _emailController.clear();
          _addresController.clear();

          links.clear();
          tags.clear();

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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomTextField(
                    text: "Nom",
                    icon: Icons.person_outline,
                    controller: _nameController,
                    isLocked: false,
                  ),
                  const SizedBox(width: 100),
                  CustomTextField(
                    text: "Adress",
                    icon: Icons.person_outline,
                    controller: _addresController,
                    isLocked: false,
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  CustomTextField(
                    text: "Email",
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    isLocked: false,
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
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 700,
                child: Row(
                  children: [
                    CustomTextField(
                      text: "Courte présentation",
                      icon: Icons.article_outlined,
                      controller: _descriptionController,
                      isLocked: false,
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
                            Offer offer = Offer(
                              companyId: companyUser.campanyProfileId,
                              companyName: companyUser.companyName,
                              address: _addresController.text,
                              description: _descriptionController.text,
                              email: _emailController.text,
                              name: _nameController.text,
                              phoneNumber: _phoneNumberController.text,
                              links: links,
                              tags: tags,
                              id: 0,
                              offerFile: "",
                              createdAt: DateTime(2022),
                              companyUserId: companyUser.id,
                            );

                            BlocProvider.of<CompanyOfferCubit>(context)
                                .createOffer(offer);
                          }
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: kButtonColor,
                          onSurface: Colors.grey,
                        ),
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
