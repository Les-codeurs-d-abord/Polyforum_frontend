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
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';

class CandidateCard extends StatelessWidget {
  final CandidateUser candidate;
  final Phase currentPhase;

  const CandidateCard(this.candidate, this.currentPhase, {Key? key})
      : super(key: key);

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
          height: 210,
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
            SizedBox(
              width: 50,
              height: 50,
              child: ProfilePicture(
                uri: candidate.logo,
                name: candidate.firstName + " " + candidate.lastName,
              ),
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
          candidate.tags.isNotEmpty ?
          SizedBox(
            height: 60,
            child: ListView(
                primary: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var tag in candidate.tags) Tags(text: tag),
                      ],
                    ),
                  )
                ]
            ),
          ) : const SizedBox(),
          const Spacer(),
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
                  isDisabled: currentPhase != Phase.wish
              ),
            ),
          ),
        ],
      ),
    );
  }
}
