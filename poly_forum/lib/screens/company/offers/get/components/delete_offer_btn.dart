import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
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
                    "Un problème est survenu, l'offre n'a pas pu être supprimée...",
              ),
            ),
          );
        } else if (state is CompanyOfferLoaded) {
          BlocProvider.of<CompanyGetOfferCubit>(context)
              .deleteLocalOffer(offer);
          showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: const CustomSnackBar.success(
                message: "L'offre a été supprimée avec succès.",
              ),
            ),
          );
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationModal(
                      title: "Supprimer une offre",
                      description:
                          "Vous êtes sur le point de supprimer l'offre ${offer.name}, en êtes-vous sûr ?");
                }).then((value) {
              if (value == ModalReturn.confirm) {
                BlocProvider.of<CompanyOfferCubit>(context).deleteOffer(offer);
              }
            });
          },
          color: kdeleteColorButton,
        );
      },
    );
  }
}
