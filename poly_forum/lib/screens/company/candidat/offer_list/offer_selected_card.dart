import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';

class OfferSelectedCard extends StatelessWidget {
  final Offer offer;

  const OfferSelectedCard({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          //           showDialog(
          //   context: context,
          //   builder: (context) {
          //     // return BlocProvider(
          //     //   create: (context) => CompanyFormCubit(CompanyRepository()),
          //     //   child: CompanyDetailDialog(offer.companyUserId),
          //     // );
          //   },
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProfilePicture(
                    uri: "",
                    defaultText: offer.companyName,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        offer.companyName,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    "Ouvrir",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_outlined),
                ],
              ),
              const Divider(),
              offer.tags.isNotEmpty
                  ? Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var tag in offer.tags) Tags(text: tag),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
              RowBtn(
                text: "Ajouter le candidat à cette offre",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
