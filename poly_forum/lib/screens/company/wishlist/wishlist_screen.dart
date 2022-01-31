import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_get_wishlist_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_wishlist_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/screens/company/wishlist/components/candidat_order_card.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/shimmer_loading.dart';

import 'components/save_choices_offer_btn.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final CompanyUser company;

  @override
  void initState() {
    super.initState();

    company = BlocProvider.of<CompanyGetUserCubit>(context).getUser();

    BlocProvider.of<CompanyGetWishlistCubit>(context).getWishlist(company);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyGetWishlistCubit, CompanyGetWishlistState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompanyGetWishlistLoaded) {
          return buildLoaded(state.wishlist, false);
        } else if (state is CompanyGetWishlistError) {
          return const ErrorScreen("error_500.jpg");
        }

        return buildLoaded([], true);
      },
    );
  }

  Widget buildLoaded(List<CompanyWish> wishlist, bool isLoading) {
    Widget child = Column(
      children: [
        isLoading
            ? const ShimmerLoading(nbBlock: 2, nbLine: 4)
            : buildList(wishlist),
        !isLoading
            ? BlocProvider(
                create: (context) => CompanyWishlistCubit(),
                child: SaveWishlistBtn(company: company, wishlist: wishlist),
              )
            : const SizedBox(height: 15),
        isLoading
            ? const ShimmerLoading(nbBlock: 10, nbLine: 7)
            : buildList(wishlist),
      ],
    );

    return BaseScreen(child: child, width: 1000);
  }

  Widget buildList(List<CompanyWish> wishlist) {
    return wishlist.isNotEmpty
        ? IgnorePointer(
            ignoring: BlocProvider.of<PhaseCubit>(context).getCurrentPhase() ==
                Phase.planning,
            child: ReorderableListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                for (int i = 0; i < wishlist.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    key: Key('$i'),
                    child: CandidatOrderCard(
                      candidate: wishlist[i].candidate,
                      rank: i,
                    ),
                  ),
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final CompanyWish item = wishlist.removeAt(oldIndex);
                  wishlist.insert(newIndex, item);
                });
              },
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Icon(
                Icons.search_off,
                size: 200,
              ),
            ),
          );
  }
}
