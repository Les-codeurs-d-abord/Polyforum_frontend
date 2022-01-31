import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/cubit/file_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/custom_container.dart';
import 'package:poly_forum/utils/constants.dart';

import 'components/edit_offer_form.dart';

// ignore: must_be_immutable
class EditOfferScreen extends StatelessWidget {
  const EditOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offer? offer =
        BlocProvider.of<CompanyOfferCubit>(context).getOfferToUpdate();

    return BaseScreen(
      child: CustomContainer(
        child: SizedBox(
          width: 1000,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocProvider(
              create: (context) => FileCubit(),
              child: EditOfferForm(offer: offer!),
            ),
          ),
        ),
      ),
    );
  }
}
