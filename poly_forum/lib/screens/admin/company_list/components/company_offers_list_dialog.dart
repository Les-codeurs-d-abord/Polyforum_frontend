import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_offers_list_dialog_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'company_offers_list.dart';

class CompanyOffersListDialog extends StatefulWidget {
  final Phase currentPhase;
  final Company company;

  const CompanyOffersListDialog(this.currentPhase, this.company, {Key? key})
      : super(key: key);

  @override
  _CompanyOffersListDialogState createState() =>
      _CompanyOffersListDialogState();
}

class _CompanyOffersListDialogState extends State<CompanyOffersListDialog> {
  List<Offer> offersList = [];
  int deleteCount = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyOffersListDialogCubit>(context)
        .fetchOffersFromCompany(widget.company.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyOffersListDialogCubit,
        CompanyOffersListDialogState>(listener: (context, state) {
      if (state is CompanyOffersListDialogLoaded) {
        offersList = state.offersList;
      }
      if (state is CompanyOffersListDialogDelete) {
        offersList.remove(state.deletedOffer);
        deleteCount++;
      }
      if (state is CompanyOffersListDialogSnackBarError) {
        showTopSnackBar(
            context,
            Padding(
              padding: kTopSnackBarPadding,
              child: CustomSnackBar.error(message: state.errorMessage),
            ));
      }
    }, builder: (context, state) {
      if (state is CompanyOffersListDialogLoading) {
        return buildCompanyDetailDialog(context, isLoading: true);
      } else if (state is CompanyOffersListDialogLoaded ||
          state is CompanyOffersListDialogDelete ||
          state is CompanyOffersListDialogSnackBarError) {
        return buildCompanyDetailDialog(context, offersList: offersList);
      } else if (state is CompanyOffersListDialogError) {
        return buildCompanyDetailDialog(context, error: state.errorMessage);
      } else {
        return buildCompanyDetailDialog(context);
      }
    });
  }

  buildCompanyDetailDialog(BuildContext context,
      {List<Offer> offersList = const [],
      bool isLoading = false,
      String error = ''}) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: "Liste des offres de l'entreprise: ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.company.companyName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
          ),
          InkResponse(
            radius: 20,
            onTap: () {
              Navigator.of(context).pop(deleteCount);
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
      content: SizedBox(
          width: 800,
          height: 500,
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      )
                    ])
              : error.isNotEmpty
                  ? Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : SingleChildScrollView(
                      primary: false,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CompanyOffersList(
                          currentPhase: widget.currentPhase,
                          offersList: offersList,
                        ),
                      ),
                    )),
    );
  }
}
