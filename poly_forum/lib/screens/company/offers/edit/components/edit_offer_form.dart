import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'custom_drop_zone.dart';
import '../../../../shared/components/custom_text_field.dart';
import '../../../../shared/components/profile/profile_links.dart';
import '../../../../shared/components/profile/profile_tags.dart';

// ignore: must_be_immutable
class EditOfferForm extends StatefulWidget {
  Offer offer;
  EditOfferForm({required this.offer, Key? key}) : super(key: key);

  @override
  _EditOfferFormState createState() => _EditOfferFormState();
}

class _EditOfferFormState extends State<EditOfferForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addresController = TextEditingController();

  List<String> links = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.offer.name;
    _descriptionController.text = widget.offer.description;
    _phoneNumberController.text = widget.offer.phoneNumber;
    _emailController.text = widget.offer.email;
    _addresController.text = widget.offer.address;
    links = widget.offer.links;
    tags = widget.offer.tags;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyOfferCubit, CompanyOfferState>(
      listener: (context, state) {
        if (state is CompanyOfferLoaded) {
          BlocProvider.of<CompanyGetOfferCubit>(context)
              .updateLocalOffer(widget.offer);

          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "Sauvegarde effectuée avec succès !",
              ),
            ),
          );
        } else if (state is CompanyOfferError) {
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
                    text: "Adresse",
                    icon: Icons.person_outline,
                    controller: _addresController,
                    isLocked: false,
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
              const CustomDropZone(),
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
                            widget.offer.name = _nameController.text;
                            widget.offer.description =
                                _descriptionController.text;
                            widget.offer.phoneNumber =
                                _phoneNumberController.text;
                            widget.offer.email = _emailController.text;
                            widget.offer.address = _addresController.text;
                            widget.offer.links = links;
                            widget.offer.tags = tags;

                            BlocProvider.of<CompanyOfferCubit>(context)
                                .updateOffer(widget.offer);
                          }
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: kButtonColor,
                          onSurface: Colors.grey,
                        ),
                        child:
                            BlocConsumer<CompanyOfferCubit, CompanyOfferState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is CompanyOfferError) {
                              return const CircularProgressIndicator();
                            } else if (state is CompanyOfferLoading) {
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
