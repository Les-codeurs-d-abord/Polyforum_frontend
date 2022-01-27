import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/admin/candidate_list/components/candidate_detail_dialog.dart';
import 'package:poly_forum/screens/company/candidat/offer_list/candidate_selected_card.dart';
import 'package:poly_forum/screens/company/candidat/offer_list/offer_select_list.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/custom_container.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferListDialog extends StatelessWidget {
  final CandidateUser candidate;
  final CompanyUser company;

  const OfferListDialog(
      {required this.company, required this.candidate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyGetOfferCubit(),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      contentPadding: EdgeInsets.zero,
      title: const Center(
        child: Text(
          "Ajouter un candidat à une offre",
          style: TextStyle(
            color: kButtonColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      content: SingleChildScrollView(
        primary: false,
        child: Container(
          width: 600,
          height: 800,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              CustomContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "Le candidat sélectionné",
                      style: TextStyle(
                        color: kButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CandidateSelectedCard(candidate: candidate),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "Vos offres",
                      style: TextStyle(
                        color: kButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    BlocProvider(
                      create: (context) => CompanyGetOfferCubit(),
                      child: OfferSelectCheckList(company: company),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
