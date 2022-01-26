import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_save_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/utils/constants.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SaveWishlistBtn extends StatelessWidget {
  final CandidateUser user;
  final List<Wish> wishlist;

  const SaveWishlistBtn({required this.user, required this.wishlist, Key? key})
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
                  BlocProvider.of<CandidateChoicesSaveCubit>(context)
                      .saveOfferChoicesEvent(user, wishlist);
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
                          Padding(
                            padding: kTopSnackBarPadding,
                            child: const CustomSnackBar.success(
                              message: "Sauvegarde effectuée avec succès !",
                            ),
                          ),
                        );
                      } else if (state is CandidateOfferSaveError) {
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
