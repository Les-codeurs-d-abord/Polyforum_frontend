import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_check_wishlist_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_wishlist_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/admin/candidate_list/components/candidate_detail_dialog.dart';
import 'package:poly_forum/screens/company/candidat/list/add_candidate.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/initials_avatar.dart';

class CandidateCard extends StatelessWidget {
  final CandidateUser candidate;
  final Phase currentPhase;

  const CandidateCard(this.candidate, this.currentPhase, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => CandidateFormCubit(CandidateRepository()),
                child: CandidateDetailDialog(candidate.id),
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          width: 400,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(context),
              const Divider(),
              buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: "",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return InitialsAvatar(
                  candidate.firstName + " " + candidate.lastName,
                  fontSize: 22,
                );
              },
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 15),
            Text(
              candidate.firstName + " " + candidate.lastName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Text(
          "Ouvrir",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.arrow_forward_outlined),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          candidate.tags.isNotEmpty
              ? Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var tag in candidate.tags) Tags(text: tag),
                  ],
                )
              : const SizedBox(),
          if (currentPhase == Phase.wish)
            const Spacer(),
          if (currentPhase == Phase.wish)
            MultiBlocProvider(
            providers: [
              BlocProvider<CompanyWishlistCubit>(
                create: (context) => CompanyWishlistCubit(),
              ),
              // BlocProvider<CompanyGetWishlistCubit>(
              //   create: (context) => CompanyGetWishlistCubit(),
              // ),
            ],
            child: BlocProvider(
              create: (context) => CompanyCheckWishlistCubit(),
              child: AddCandidate(
                candidate: candidate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
