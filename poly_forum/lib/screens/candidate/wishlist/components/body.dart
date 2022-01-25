import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_cubit.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_save_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/screens/candidate/wishlist/components/save_choices_offer_btn.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/initials_avatar.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Wish>? wishlist;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateChoicesCubit>(context)
        .offerChoicesListEvent(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateChoicesCubit, CandidateChoicesState>(
      listener: (context, state) {
        if (state is CandidateChoicesScreenLoaded) {
          wishlist = state.offerList;
        }
      },
      builder: (context, state) {
        if (state is CandidateChoicesScreenLoaded) {
          return buildLoaded(false);
        } else if (state is CandidateChoicesScreenError) {
          return const ErrorScreen("error_500.jpg");
        }

        return buildLoaded(true);
      },
    );
  }

  Widget buildLoaded(bool isLoading) {
    Widget child = Column(
      children: [
        isLoading ? buildloading() : buildList(),
        !isLoading
            ? BlocProvider(
                create: (context) => CandidateChoicesSaveCubit(),
                child: SaveWishlistBtn(user: widget.user, wishlist: wishlist!),
              )
            : const SizedBox(height: 15),
      ],
    );

    return BaseScreen(
        child: child, title: "Organisation des voeux", width: 1000);
  }

  Widget buildloading() {
    return Shimmer.fromColors(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < 7; i++)
                Container(
                  height: 5.0,
                  color: Colors.white,
                ),
            ],
          ),
        ),
        itemCount: 10,
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }

  ReorderableListView buildList() {
    List<Wish> localwishlist = wishlist ?? [];
    return ReorderableListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        for (int i = 0; i < localwishlist.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            key: Key('$i'),
            child: Card(
              elevation: 15,
              child: InkWell(
                onTap: () {},
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(right: 30, top: 5),
                    child: SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InitialsAvatar(
                                          localwishlist[i].offer.companyName),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localwishlist[i].offer.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            localwishlist[i].offer.companyName,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: <Widget>[
                                        for (int index = 0;
                                            index <
                                                localwishlist[i]
                                                    .offer
                                                    .tags
                                                    .length;
                                            index++)
                                          Tags(
                                            text: localwishlist[i]
                                                .offer
                                                .tags[index],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: kSecondaryColor,
                            radius: 25,
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Wish item = wishlist!.removeAt(oldIndex);
          wishlist!.insert(newIndex, item);
        });
      },
    );
  }
}