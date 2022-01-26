import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/admin_planning_candidates_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/screens/admin/planning/components/candidates/planning_component.dart';

import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Candidate>? listCandidates;
  List<CompanyMinimal>? listCompanies;
  Candidate? candidateSelected;
  Planning? planning;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminPlanningCandidatesCubit>(context).fetchAllCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminPlanningCandidatesCubit,
        AdminPlanningCandidatesState>(listener: (context, state) {
      if (state is AdminPlanningCandidatesError) {
      } else if (state is AdminPlanningCandidatesLoaded) {
        listCandidates = state.listCandidates;
      } else if (state is AdminPlanningCandidatesAndPlanningLoaded) {
        planning = state.planning;
      } else if (state is AdminPlanningCandidatesAddMeeting) {
        listCompanies = state.listCompanies;
      }
    }, builder: (context, state) {
      if (state is AdminPlanningCandidatesLoading) {
        return buildloadingScreen();
      } else if (state is AdminPlanningCandidatesLoaded) {
        return buildLoadedScreen();
      } else if (state is AdminPlanningCandidatesAndPlanningLoaded) {
        return buildLoadedScreenWithPlanning();
      } else if (state is AdminPlanningCandidatesError) {
        return buildErrorScreen();
      }
      return buildInitialPlanning();
    });
  }

  Widget buildInitialPlanning() {
    return Image.asset(
      "images/no_result.jpg",
      width: 1200,
    );
  }

  Widget buildloadingScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

  Widget buildLoadedScreen([bool isPlanningLoaded = false]) {
    if (listCandidates!.isNotEmpty) {
      return Column(children: [
        DropdownButton<Candidate>(
          icon: const Icon(Icons.account_circle),
          dropdownColor: Colors.grey[300],
          value: candidateSelected,
          onChanged: (Candidate? newValue) {
            setState(() {
              candidateSelected = newValue!;
              callPlanningRequest();
            });
          },
          items: listCandidates!
              .map<DropdownMenuItem<Candidate>>((Candidate candidate) {
            return DropdownMenuItem<Candidate>(
              value: candidate,
              child: Text('${candidate.firstName} ${candidate.lastName}',
                  style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
        ),
        Container(),
      ]);
    } else {
      return buildInitialPlanning();
    }
  }

  Widget buildLoadedScreenWithPlanning() {
    return Column(
      children: [
        buildLoadedScreen(true),
        PlanningWidget(
          planning: planning!,
        )
      ],
    );
  }

  Widget buildErrorScreen() {
    return Image.asset(
      "images/no_result.jpg",
      width: 1200,
    );
  }

  void callPlanningRequest() {
    BlocProvider.of<AdminPlanningCandidatesCubit>(context)
        .fetchPlanningForGivenCandidate(candidateSelected!.userId);
  }
}
