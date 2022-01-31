import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_cubit.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/candidate/wishlist/candidate_get_wishlist_cubit.dart';
import 'package:poly_forum/cubit/candidate/wishlist/candidate_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddWishlistBtn extends StatefulWidget {
  final CandidateUser user;
  final Offer offer;

  const AddWishlistBtn({required this.user, required this.offer, Key? key})
      : super(key: key);

  @override
  State<AddWishlistBtn> createState() => _AddWishlistBtnState();
}

class _AddWishlistBtnState extends State<AddWishlistBtn> {
  bool isOnRemoveMode = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateGetWishlistCubit>(context)
        .inOfferInWishlist(widget.user, widget.offer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateGetWishlistCubit, CandidateGetWishlistState>(
      listener: (context, state) {
        if (state is CandidateIsOfferInWishlistLoaded) {
          isOnRemoveMode = state.isInWishlist;
        }
      },
      builder: (context, state) {
        if (state is CandidateIsOfferInWishlistLoaded) {
          return buildLoaded(isOnRemoveMode);
        }

        return const RowBtn(
          text: "",
          onPressed: null,
          isLoading: true,
        );
      },
    );
  }

  Widget buildLoaded(bool isRemove) {
    return BlocConsumer<CandidateWishlistCubit, CandidateWishlistState>(
      listener: (context, state) {
        if (state is CandidateWishlistError) {
          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.error(
                message:
                    "Un problème est survenue, la sauvegarde pas été effectuée...",
              ),
            ),
          );
        } else if (state is CandidateWishlistLoaded) {
          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "La sauvegarde a été faite avec succès !",
              ),
            ),
          );

          setState(() {
            BlocProvider.of<CandidateChoicesCubit>(context)
                .offerChoicesListEvent(widget.user);
            isOnRemoveMode = !isOnRemoveMode;
          });
        }
      },
      builder: (context, state) {
        if (state is CandidateWishlistLoading) {
          return const RowBtn(
            text: "",
            onPressed: null,
            isLoading: true,
          );
        }

        if (isRemove) {
          return RowBtn(
            text: "Retirer de mes voeux",
            onPressed: () {
              BlocProvider.of<CandidateWishlistCubit>(context)
                  .removeWish(widget.offer, widget.user);
            },
            color: kdeleteColorButton,
          );
        } else {
          return RowBtn(
            text: "Ajouter à mes voeux",
            onPressed: () {
              BlocProvider.of<CandidateWishlistCubit>(context)
                  .addWish(widget.offer, widget.user);
            },
          );
        }
      },
    );
  }
}
