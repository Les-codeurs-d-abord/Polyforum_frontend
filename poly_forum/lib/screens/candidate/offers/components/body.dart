import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/candidate/update_candidate_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/offer_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? currentInput;

  @override
  void initState() {
    super.initState();
    callOfferListEvent();
  }

  void callOfferListEvent() {
    BlocProvider.of<CandidateOfferScreenCubit>(context)
        .offerListEvent(currentInput);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateOfferScreenCubit, CandidateOfferScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CandidateOfferScreenLoaded) {
          return buildLoaded([], false);
        } else if (state is CandidateOfferScreenError) {
          return const ErrorScreen("error_500.jpg");
        }

        return buildLoaded([], true);
      },
    );
  }

  // Widget buildScreen() {
  //   return SingleChildScrollView(
  //     primary: false,
  //     child: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Center(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Container(
  //               width: 1000,
  //               padding: const EdgeInsets.only(right: 200),
  //               child: Row(
  //                 children: [
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: const InputDecoration(
  //                         suffixIcon: Icon(Icons.search, size: 30),
  //                         border: OutlineInputBorder(),
  //                         labelText: "Rechercher...",
  //                       ),
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.normal,
  //                         fontSize: 20,
  //                       ),
  //                       onChanged: (value) {
  //                         currentInput = value;
  //                       },
  //                       onSubmitted: (value) {
  //                         callOfferListEvent();
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             BlocConsumer<CandidateOfferScreenCubit,
  //                 CandidateOfferScreenState>(
  //               listener: (context, state) {
  //                 if (state is CandidateOfferScreenError) {
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: Text(state.msg),
  //                     ),
  //                   );
  //                 } else if (state is CandidateOfferScreenLoaded) {
  //                   if (state.offerList.isEmpty) {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       const SnackBar(
  //                         content: Text("Aucun résultat trouvé."),
  //                       ),
  //                     );
  //                   }
  //                 }
  //               },
  //               builder: (context, state) {
  //                 if (state is CandidateOfferScreenLoading) {
  //                   return buildloadingScreen();
  //                 } else if (state is CandidateOfferScreenLoaded) {
  //                   return buildLoadedScreen(state.offerList);
  //                 } else if (state is CandidateOfferScreenError) {
  //                   return buildErrorOffers();
  //                 }

  //                 return buildInitialOffers();
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildLoaded(List<Offer> offerList, bool isLoading) {
    return SingleChildScrollView(
      primary: false,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: SizedBox(
                  width: 1100,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Les offres proposées",
                          style: TextStyle(
                            color: kButtonColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
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
                        ],
                      ),
                      isLoading ? buildloading() : buildList(offerList),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildloading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Shimmer.fromColors(
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
      ),
    );
  }

  Widget buildList(List<Offer> offerList) {
    return Container(
      child: offerList.isNotEmpty
          ? Column(
              children: [
                for (var offer in offerList) OfferCard(offer),
              ],
            )
          : Center(
              child: Image.asset(
                "images/no_result.jpg",
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
