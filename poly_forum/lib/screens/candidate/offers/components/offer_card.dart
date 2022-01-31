import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/cubit/candidate/wishlist/candidate_get_wishlist_cubit.dart';
import 'package:poly_forum/cubit/candidate/wishlist/candidate_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/admin/company_list/components/company_detail_dialog.dart';
import 'package:poly_forum/screens/candidate/offers/components/add_wishlist_btn.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final CandidateUser user;
  final Phase currentPhase;

  const OfferCard(this.offer, this.user, this.currentPhase, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        elevation: 20,
        child: InkWell(
          onTap: offer.offerFile.isNotEmpty
              ? () {
                  launch("http://$kServer/api/res/${offer.offerFile}");
                }
              : null,
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
                        child: buildBody(context),
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
              SizedBox(
                width: 50,
                height: 50,
                child: ProfilePicture(
                  uri: offer.logoUri,
                  name: offer.companyName,
                ),
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
        // const Spacer(),
        offer.offerFile.isNotEmpty
            ? const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Ouvrir l'offre",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Cette offre ne contient aucun document à afficher",
                    style: TextStyle(
                      color: Colors.red,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_forward_outlined),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            offer.description,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
            style: const TextStyle(),
          ),
        ),
        if (currentPhase == Phase.wish) const Spacer(),
        if (currentPhase == Phase.wish)
          MultiBlocProvider(
            providers: [
              BlocProvider<CandidateWishlistCubit>(
                create: (context) => CandidateWishlistCubit(),
              ),
              BlocProvider<CandidateGetWishlistCubit>(
                create: (context) => CandidateGetWishlistCubit(),
              ),
            ],
            child: AddWishlistBtn(
              offer: offer,
              user: user,
            ),
          ),
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
                Flexible(
                  child: TextButton(
                    child: Text(offer.email),
                    onPressed: () {
                      launch("mailto:${offer.email}");
                    },
                  ),
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
