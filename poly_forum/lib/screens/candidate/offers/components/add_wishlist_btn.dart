import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWishlistBtn extends StatelessWidget {
  final CandidateUser user;
  final Offer offer;

  const AddWishlistBtn({required this.user, required this.offer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CandidateWishlistLoading) {
          return RowBtn(
            text: "Continuer pour postuler",
            onPressed: () {
              BlocProvider.of<CandidateWishlistCubit>(context)
                  .addWishlist(offer, user);
            },
            isLoading: true,
          );
        }

        return RowBtn(text: "Continuer pour postuler", onPressed: () {});
      },
    );
  }
}
