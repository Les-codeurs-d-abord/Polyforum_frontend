import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/candidat/company_candidat_list_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:shimmer/shimmer.dart';

import 'candidate_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final Phase currentPhase;

  @override
  void initState() {
    super.initState();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
    BlocProvider.of<CompanyCandidatListCubit>(context).getCandidateList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCandidatListCubit, CompanyCandidatListState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompanyCandidatListLoaded) {
          return buildLoaded(state.candidateList, false);
        } else if (state is CompanyCandidatListLoadedWithFilter) {
          return buildLoaded(state.candidateList, false);
        } else if (state is CompanyCandidatListError) {
          return const ErrorScreen("error_500.jpg");
        }

        return buildLoaded([], true);
      },
    );
  }

  Widget buildLoaded(List<CandidateUser> candidateList, bool isLoading) {
    return Column(
      children: [
        SizedBox(
          width: 700,
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
              BlocProvider.of<CompanyCandidatListCubit>(context)
                  .getCandidateListWithFilteringEvent(value);
            },
          ),
        ),
        const SizedBox(height: 50),
        isLoading ? buildloading() : buildList(candidateList),
      ],
    );
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

  Widget buildList(List<CandidateUser> candidateList) {
    return Column(
      children: [
        Container(
          child: candidateList.isNotEmpty
              ? Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  children: [
                    for (var candidate in candidateList)
                      CandidateCard(candidate, currentPhase),
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
      ],
    );
  }
}
