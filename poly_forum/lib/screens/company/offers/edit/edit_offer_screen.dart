import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/edit_offer_form.dart';

// ignore: must_be_immutable
class EditOfferScreen extends StatelessWidget {
  Offer offer;

  EditOfferScreen({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocProvider(
        create: (context) => CompanyOfferCubit(),
        child: EditOfferForm(offer: offer),
      ),
      width: 1200,
    );
  }
}
