import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_save_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/utils/constants.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SaveChoicesOfferBtn extends StatelessWidget {
  final List<Offer> offers;
  final bool isModify;

  const SaveChoicesOfferBtn(
      {required this.offers, required this.isModify, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  if (isModify) {
                    BlocProvider.of<CandidateChoicesSaveCubit>(context)
                        .saveOfferChoicesEvent(offers);
                  } else {
                    showTopSnackBar(
                      context,
                      const Padding(
                        padding: EdgeInsets.only(left: 300, right: 10),
                        child: CustomSnackBar.info(
                          message: "Aucune modification détectéés.",
                        ),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: kButtonColor,
                  onSurface: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<CandidateChoicesSaveCubit,
                      CandidateChoicesSaveState>(
                    listener: (context, state) {
                      if (state is CandidateChoicesSaveLoaded) {
                        showTopSnackBar(
                          context,
                          const Padding(
                            padding: EdgeInsets.only(left: 300, right: 10),
                            child: CustomSnackBar.success(
                              message: "Sauvegarde effectuée avec succès !",
                            ),
                          ),
                        );
                      } else if (state is CandidateOfferSaveError) {
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
                      if (state is CandidateChoicesSaveLoading) {
                        return const CircularProgressIndicator();
                      }
                      return const Text(
                        'Sauvegarder',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
