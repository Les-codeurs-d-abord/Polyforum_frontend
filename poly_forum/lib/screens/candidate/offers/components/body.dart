import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/candidate/drop_down_offer_tag_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/offer_card.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags_drop_down_btn.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateOfferScreenCubit>(context)
        .offerListEvent(const Tag(id: 0, label: ""));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocConsumer<CandidateOfferScreenCubit, CandidateOfferScreenState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CandidateOfferScreenLoading) {
                  return buildloadingScreen();
                } else if (state is CandidateOfferScreenLoaded) {
                  return buildLoadedScreen(state.offerList);
                }

                return buildInitialOffers(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildloadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoadedScreen(List<Offer> offerList) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 1000,
            padding: const EdgeInsets.only(right: 200),
            child: Row(
              children: [
                const Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search, size: 30),
                      border: OutlineInputBorder(),
                      labelText: "Rechercher...",
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                BlocProvider(
                  create: (context) => DropDownOfferTagCubit(),
                  child: const TagsDropDownBtn(),
                ),
              ],
            ),
          ),
          for (var offer in offerList) OfferCard(offer),
        ],
      ),
    );
    // return SizedBox(
    //   height: 2000,
    //   child: ResponsiveGridList(
    //     desiredItemWidth: 400,
    //     minSpacing: 20,
    //     children: [
    //       for (var offer in offerList) OfferCard(offer),
    //     ],
    //   ),
    // );
  }

  Widget buildInitialOffers(BuildContext context) {
    return const SizedBox();
  }
}
