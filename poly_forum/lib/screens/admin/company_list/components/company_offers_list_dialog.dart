import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_offers_list_dialog_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';

class CompanyOffersListDialog extends StatefulWidget {
  final Company company;

  const CompanyOffersListDialog(this.company, {Key? key}) : super(key: key);

  @override
  _CompanyOffersListDialogState createState() => _CompanyOffersListDialogState();
}

class _CompanyOffersListDialogState extends State<CompanyOffersListDialog> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyOffersListDialogCubit>(context).fetchOffersFromCompany(widget.company.id);
  }

  @override
  Widget build(BuildContext context) {
    List<Offer> offersList = [];

    return BlocConsumer<CompanyOffersListDialogCubit, CompanyOffersListDialogState>(
        listener: (context, state) {
          if (state is CompanyOffersListDialogLoaded) {
            offersList = state.offersList;
          }
        },
        builder: (context, state) {
          if (state is CompanyOffersListDialogLoading) {
            return buildCompanyDetailDialog(context, isLoading: true);
          } else if (state is CompanyOffersListDialogLoaded) {
            return buildCompanyDetailDialog(context, offersList: offersList);
          } else if (state is CompanyOffersListDialogError) {
            return buildCompanyDetailDialog(context, error: state.errorMessage);
          } else {
            return buildCompanyDetailDialog(context);
          }
        }
    );
  }

  buildCompanyDetailDialog(BuildContext context, {List<Offer> offersList = const [], bool isLoading = false, String error = ''}) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Liste des offres de l'entreprise ${widget.company.companyName}",
              style: const TextStyle(
                  fontSize: 22
              ),
            ),
          ),
          InkResponse(
            radius: 20,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
      content: SizedBox(
          width: 900,
          height: 500,
          child: isLoading ?
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )
              ]
          ) :
          error.isNotEmpty ?
          Text(
            error,
            style: const TextStyle(
                color: Colors.red,
                fontSize: 18
            ),
          ) :
          SingleChildScrollView(
            child: Container(),
          )
      ),
    );
  }
}
