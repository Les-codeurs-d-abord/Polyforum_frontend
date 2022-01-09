import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/candidate/offer_details/offer_details_screen.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard(this.offer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
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
          child: Container(
            padding: const EdgeInsets.all(15),
            width: 1000,
            child: Column(
              children: [
                buildHeader(),
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
                const SizedBox(height: 25),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: kButtonColor,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "Continuer pour postuler",
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: offer.icon,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
          Row(
            children: const [
              Icon(
                Icons.phone,
                size: 25,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "0617171717",
                  style: TextStyle(),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(
                Icons.mail_outline,
                size: 25,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "support@mikapps.fr",
                  style: TextStyle(),
                ),
              )
            ],
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
            children: const [
              Icon(
                Icons.location_on_outlined,
                size: 25,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "69100, Villeurbanne",
                  style: TextStyle(),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Liens utils",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  child: const Text(
                    'https://www.inetum.com/fr',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => launch('https://www.inetum.com/fr'),
                ),
              ),
            ],
          ),
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
                  child: const Text(
                    'https://www.inetum.com/fr',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => launch('https://www.inetum.com/fr'),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Tags",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
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
    );
  }
}
