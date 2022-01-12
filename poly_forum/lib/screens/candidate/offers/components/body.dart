import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/candidate/drop_down_offer_tag_cubit.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/offer_card.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags_drop_down_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

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
        .offerListEvent(currentTag, currentInput);
  }

  Tag? currentTag;
  String? currentInput;

  void callOfferListEvent() {
    BlocProvider.of<CandidateOfferScreenCubit>(context)
        .offerListEvent(currentTag, currentInput);
  }

  void onDropDownValueChanged(Tag value) {
    if (currentTag?.id != value.id) {
      currentTag = value;
      callOfferListEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 1000,
                padding: const EdgeInsets.only(right: 200),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search, size: 30),
                          border: OutlineInputBorder(),
                          labelText: "Rechercher...",
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                        onChanged: (value) {
                          currentInput = value;
                        },
                        onSubmitted: (value) {
                          callOfferListEvent();
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    BlocProvider(
                      create: (context) => DropDownOfferTagCubit(),
                      child: TagsDropDownBtn(onDropDownValueChanged),
                    ),
                  ],
                ),
              ),
              BlocConsumer<CandidateOfferScreenCubit,
                  CandidateOfferScreenState>(
                listener: (context, state) {
                  if (state is CandidateOfferScreenError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.msg),
                      ),
                    );
                  } else if (state is CandidateOfferScreenLoaded) {
                    if (state.offerList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Aucun résultat trouvé."),
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is CandidateOfferScreenLoading) {
                    return buildloadingScreen();
                  } else if (state is CandidateOfferScreenLoaded) {
                    return buildLoadedScreen(state.offerList);
                  } else if (state is CandidateOfferScreenError) {
                    return buildErrorOffers();
                  }

                  return buildInitialOffers();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildloadingScreen() {
    return SizedBox(
      width: 1000,
      height: 1000,
      // color: Colors.red,
      child: Shimmer.fromColors(
        child: ListView.builder(
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
          itemCount: 4,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
    );
  }

  Widget buildLoadedScreen(List<Offer> offerList) {
    return Container(
      child: offerList.isNotEmpty
          ? Column(
              children: [
                for (var offer in offerList) OfferCard(offer),
              ],
            )
          : buildInitialOffers(),
    );
  }

  Widget buildInitialOffers() {
    return Image.asset(
      "images/no_result.jpg",
      width: 1200,
    );
  }

  Widget buildErrorOffers() {
    return Image.asset(
      "images/error_500.jpg",
      width: 1200,
    );
  }
}
