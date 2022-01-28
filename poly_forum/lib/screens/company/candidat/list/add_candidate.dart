import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_check_wishlist_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_get_wishlist_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddCandidate extends StatefulWidget {
  final CandidateUser candidate;

  const AddCandidate({required this.candidate, Key? key}) : super(key: key);

  @override
  _AddCandidateState createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  bool isOnRemoveMode = false;
  late final CompanyUser company;

  @override
  void initState() {
    super.initState();
    company = BlocProvider.of<CompanyGetUserCubit>(context).getUser();
    BlocProvider.of<CompanyCheckWishlistCubit>(context)
        .inOfferInWishlist(widget.candidate, company);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCheckWishlistCubit, CompanyCheckWishlistState>(
      listener: (context, state) {
        if (state is CompanyCheckWishlistLoaded) {
          isOnRemoveMode = state.isInWishlist;
        }
      },
      builder: (context, state) {
        if (state is CompanyCheckWishlistLoaded) {
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
    return BlocConsumer<CompanyWishlistCubit, CompanyWishlistState>(
      listener: (context, state) {
        if (state is CompanyWishlistError) {
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
        } else if (state is CompanyWishlistLoaded) {
          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "La sauvegarde a été faite avec succès !",
              ),
            ),
          );
          BlocProvider.of<CompanyGetWishlistCubit>(context)
              .getWishlist(company);
          setState(() {
            isOnRemoveMode = !isOnRemoveMode;
          });
        }
      },
      builder: (context, state) {
        if (state is CompanyWishlistLoading) {
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
              BlocProvider.of<CompanyWishlistCubit>(context)
                  .removeWish(company, widget.candidate);
            },
            color: Colors.red,
          );
        } else {
          return RowBtn(
            text: "Ajouter à mes voeux",
            onPressed: () {
              BlocProvider.of<CompanyWishlistCubit>(context)
                  .addWish(company, widget.candidate);
            },
          );
        }
      },
    );
  }
}
