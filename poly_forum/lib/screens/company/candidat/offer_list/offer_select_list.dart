import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/company/candidat/offer_list/offer_selected_card.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/shimmer_loading.dart';
import 'package:shimmer/shimmer.dart';

class OfferSelectCheckList extends StatefulWidget {
  final CompanyUser company;

  const OfferSelectCheckList({required this.company, Key? key})
      : super(key: key);

  @override
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferSelectCheckList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyGetOfferCubit>(context).getOfferList(widget.company);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyGetOfferCubit, CompanyGetOfferState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
    return isLoading
        ? const ShimmerLoading(nbBlock: 1, nbLine: 3)
        : buildList(offerList);
  }

  Widget buildList(List<Offer> offerList) {
    return Column(
      children: [
        Container(
          child: offerList.isNotEmpty
              ? Column(
                  children: [
                    for (var offer in offerList)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: OfferSelectedCard(offer: offer),
                      ),
                  ],
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: Icon(
                      Icons.search_off,
                      size: 100,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
