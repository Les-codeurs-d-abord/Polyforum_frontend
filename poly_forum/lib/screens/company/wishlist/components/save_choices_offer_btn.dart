import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/wishlist/company_wishlist_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/utils/constants.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SaveWishlistBtn extends StatelessWidget {
  final CompanyUser company;
  final List<CompanyWish> wishlist;

  const SaveWishlistBtn(
      {required this.company, required this.wishlist, Key? key})
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
                  BlocProvider.of<CompanyWishlistCubit>(context)
                      .updateWishlist(company, wishlist);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: kButtonColor,
                  onSurface: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      BlocConsumer<CompanyWishlistCubit, CompanyWishlistState>(
                    listener: (context, state) {
                      if (state is CompanyWishlistLoaded) {
                        showTopSnackBar(
                          context,
                          Padding(
                            padding: kTopSnackBarPadding,
                            child: const CustomSnackBar.success(
                              message: "Sauvegarde effectuée avec succès !",
                            ),
                          ),
                        );
                      } else if (state is CompanyWishlistError) {
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
                      if (state is CompanyWishlistLoading) {
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
