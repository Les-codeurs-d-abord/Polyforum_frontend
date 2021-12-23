import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/offers/components/offer_card.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags_drop_down_btn.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search, size: 35),
                        border: OutlineInputBorder(),
                        labelText: "Rechercher...",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Spacer(),
                  TagsDropDownBtn(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2000, //define by nb line x height
            child: ResponsiveGridList(
              desiredItemWidth: 400,
              minSpacing: 20,
              children: const [
                OfferCard(),
                OfferCard(),
                OfferCard(),
                OfferCard(),
                OfferCard(),
                OfferCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
