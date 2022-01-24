import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddWishlistBtn extends StatelessWidget {
  final CandidateUser user;
  final Offer offer;

  const AddWishlistBtn({required this.user, required this.offer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateWishlistCubit, CandidateWishlistState>(
      listener: (context, state) {
        if (state is CandidateWishlistError) {
          showTopSnackBar(
            context,
            const Padding(
              padding: EdgeInsets.only(left: 300, right: 10),
              child: CustomSnackBar.error(
                message:
                    "Un problème est survenue, l'ajout n'a pas été effectué...",
              ),
            ),
          );
        } else if (state is CandidateWishlistLoaded) {
          showTopSnackBar(
            context,
            const Padding(
              padding: EdgeInsets.only(left: 300, right: 10),
              child: CustomSnackBar.success(
                message: "L'ajout a été fait avec succès !",
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CandidateWishlistLoading) {
          return RowBtn(
            text: "Retirer de ma liste",
            onPressed: () {
              // BlocProvider.of<CandidateWishlistCubit>(context)
              //     .addWishlist(offer, user);
            },
            isLoading: true,
          );
        }

        return RowBtn(
          text: "Continuer pour postuler",
          onPressed: () {
            BlocProvider.of<CandidateWishlistCubit>(context)
                .addWishlist(offer, user);
          },
        );
      },
    );
  }
}
