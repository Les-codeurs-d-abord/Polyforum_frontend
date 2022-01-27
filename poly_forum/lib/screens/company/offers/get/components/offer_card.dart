import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/admin/company_list/components/company_detail_dialog.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/initials_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_offer_btn.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard(this.offer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        elevation: 20,
        child: InkWell(
          onTap: () {
            launch("http://localhost:8080/api/res/${offer.offerFile}");
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            width: 1000,
            child: Column(
              children: [
                buildHeader(context),
                const Divider(),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: buildBody(),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: buildInfo(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => CompanyFormCubit(CompanyRepository()),
                  child: CompanyDetailDialog(offer.companyUserId),
                );
              },
            );
          },
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: "",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  return InitialsAvatar(offer.companyName);
                },
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 15),
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
            ],
          ),
        ),
        const Spacer(),
        const Text(
          "Ouvrir l'offre",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_forward_outlined),
      ],
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            offer.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
            style: const TextStyle(),
          ),
        ),
        const Spacer(),
        DeleteOfferBtn(offer: offer),
      ],
    );
  }

  Widget buildInfo() {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contacts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(offer.phoneNumber),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.mail_outline,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(offer.email),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Lieu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(offer.address),
              )
            ],
          ),
          const SizedBox(height: 20),
          offer.links.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Liens",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    for (var link in offer.links)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.link_outlined,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              child: Text(
                                link,
                                style: const TextStyle(color: Colors.blue),
                              ),
                              onTap: () => launch(link),
                            ),
                          )
                        ],
                      ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          offer.tags.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var tag in offer.tags) Tags(text: tag),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
