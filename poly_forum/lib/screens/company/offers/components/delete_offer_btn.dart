import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DeleteOfferBtn extends StatelessWidget {
  final Offer offer;

  const DeleteOfferBtn({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyOfferCubit(),
      child: buildComponent(),
    );
  }

  Widget buildComponent() {
    return BlocConsumer<CompanyOfferCubit, CompanyOfferState>(
      listener: (context, state) {
        if (state is CompanyOfferError) {
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
        } else if (state is CompanyOfferLoaded) {
          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "La sauvegarde a été faite avec succès !",
              ),
            ),
          );
          BlocProvider.of<CompanyGetOfferCubit>(context)
              .deleteLocalOffer(offer);
        }
      },
      builder: (context, state) {
        if (state is CompanyOfferLoading) {
          return const RowBtn(
            text: "",
            onPressed: null,
            isLoading: true,
          );
        }

        return RowBtn(
          text: "Supprimer cette offre",
          onPressed: () {
            BlocProvider.of<CompanyOfferCubit>(context).deleteOffer(offer);
          },
          color: kRedButton,
        );
      },
    );
  }
}
