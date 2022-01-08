import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/candidate/offer_details/offer_details_screen.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard(this.offer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OfferDetailsScreen(),
            ),
          );
        },
        child: SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: offer.icon,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                    const Spacer(),
                    const Icon(Icons.arrow_forward_outlined),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.topLeft,
                  height: 110,
                  child: Text(
                    offer.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    style: const TextStyle(),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var tag in offer.tags) Tags(text: tag.label),
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
}
