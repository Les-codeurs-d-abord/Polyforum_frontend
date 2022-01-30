import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/offer_card.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final Phase currentPhase;
  List<Offer> offerListSaved = [];

  @override
  void initState() {
    super.initState();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
    BlocProvider.of<CandidateOfferScreenCubit>(context).offerListEvent();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateOfferScreenCubit, CandidateOfferScreenState>(
      listener: (context, state) {
        if (state is CandidateOfferScreenLoaded) {
          offerListSaved = state.offerList;
        }
      },
      // buildWhen: (previous, current) {
      //   print(previous);
      //   print(current);
      //   if (previous is CandidateOfferScreenLoaded &&
      //       current is CandidateOfferScreenLoading) {
      //     return false;
      //   }
      //   return true;
      // },
      builder: (context, state) {
        if (state is CandidateOfferScreenLoaded) {
          return buildLoaded(state.offerList, false);
        } else if (state is CandidateOfferScreenLoadedWithFilter) {
          return buildLoaded(state.offerList, false);
        } else if (state is CandidateOfferScreenError) {
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
                    BlocProvider.of<CandidateOfferScreenCubit>(context)
                        .offerListWithFilteringEvent(offerListSaved, value);
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
    return Container(
      child: offerList.isNotEmpty
          ? Column(
              children: [
                for (var offer in offerList) OfferCard(offer, widget.user, currentPhase),
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
    );
  }
}
