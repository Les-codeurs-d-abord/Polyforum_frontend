import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/company/offers/edit/edit_offer_screen.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/row_btn.dart';
import 'package:shimmer/shimmer.dart';

import 'offer_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    CompanyUser user = BlocProvider.of<CompanyGetUserCubit>(context).getUser();
    BlocProvider.of<CompanyGetOfferCubit>(context).getOfferList(user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyGetOfferCubit, CompanyGetOfferState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompanyGetOfferLoaded) {
          return buildLoaded(state.offerList, false);
        } else if (state is CompanyGetOfferLoadedWithFilter) {
          return buildLoaded(state.offerList, false);
        } else if (state is CompanyGetOfferError) {
          return const ErrorScreen("error_500.jpg");
        }

        return buildLoaded([], true);
      },
    );
  }

  Widget buildLoaded(List<Offer> offerList, bool isLoading) {
    Widget child = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search, size: 30),
                    border: OutlineInputBorder(),
                    labelText: "Rechercher...",
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    BlocProvider.of<CompanyGetOfferCubit>(context)
                        .offerListWithFilteringEvent(value);
                  },
                ),
              ),
            ),
          ],
        ),
        isLoading ? buildloading() : buildList(offerList),
      ],
    );
    return BaseScreen(child: child, width: 1100);
  }

  Widget buildloading() {
    return Shimmer.fromColors(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < 7; i++)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            ],
          ),
        ),
        itemCount: 2,
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }

  Widget buildList(List<Offer> offerList) {
    return Column(
      children: [
        Container(
          child: offerList.isNotEmpty
              ? Column(
                  children: [
                    for (var offer in offerList) OfferCard(offer),
                  ],
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: Icon(
                      Icons.search_off,
                      size: 200,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 30),
        RowBtn(
          text: "Ajouter une offre",
          onPressed: () {
            BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(2);
          },
        ),
      ],
    );
  }
}
