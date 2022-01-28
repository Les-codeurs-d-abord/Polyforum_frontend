import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/shared/components/custom_container.dart';
import 'package:poly_forum/utils/constants.dart';

import 'components/edit_offer_form.dart';

// ignore: must_be_immutable
class EditOfferScreen extends StatelessWidget {
  Offer offer;

  EditOfferScreen({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          BlocProvider(
            create: (context) => CompanyOfferCubit(),
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SingleChildScrollView(
                primary: false,
                child: CustomContainer(
                  child: SizedBox(
                    width: 1000,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: EditOfferForm(offer: offer),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.only(bottom: 20),
            child: Material(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.grey[50],
              elevation: 10,
              child: const Center(
                child: Text(
                  "Modifier une offre",
                  style: TextStyle(
                    color: kButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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
