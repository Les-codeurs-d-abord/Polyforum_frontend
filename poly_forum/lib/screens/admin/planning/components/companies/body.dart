import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/companies/admin_planning_companies_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/data/models/candidate_minimal_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/screens/admin/planning/components/companies/planning_component.dart';

import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Company>? listCompanies;
  List<CandidateMinimal>? listCandidates;
  Company? companySelected;
  Planning? planning;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminPlanningCompaniesCubit>(context).fetchAllCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminPlanningCompaniesCubit,
        AdminPlanningCompaniesState>(listener: (context, state) {
      if (state is AdminPlanningCompaniesError) {
      } else if (state is AdminPlanningCompaniesLoaded) {
        listCompanies = state.listCompanies;
      } else if (state is AdminPlanningCompaniesAndPlanningLoaded) {
        planning = state.planning;
      } else if (state is AdminPlanningCompaniesAddMeeting) {
        listCandidates = state.listCandidates;
      }
    }, builder: (context, state) {
      if (state is AdminPlanningCompaniesLoading) {
        return buildloadingScreen();
      } else if (state is AdminPlanningCompaniesLoaded) {
        return buildLoadedScreen();
      } else if (state is AdminPlanningCompaniesAndPlanningLoaded) {
        return buildLoadedScreenWithPlanning();
      } else if (state is AdminPlanningCompaniesError) {
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
    if (listCompanies!.isNotEmpty) {
      return Column(children: [
        DropdownButton<Company>(
          icon: const Icon(Icons.business),
          dropdownColor: Colors.grey[300],
          value: companySelected,
          onChanged: (Company? newValue) {
            setState(() {
              companySelected = newValue!;
              callPlanningRequest();
            });
          },
          items:
              listCompanies!.map<DropdownMenuItem<Company>>((Company company) {
            return DropdownMenuItem<Company>(
              value: company,
              child: Text(company.companyName,
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
    BlocProvider.of<AdminPlanningCompaniesCubit>(context)
        .fetchPlanningForGivenCompany(companySelected!.id);
  }
}
