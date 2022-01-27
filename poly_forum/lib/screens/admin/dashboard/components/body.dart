import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/cubit/admin/dashboard/side_panel_cubit.dart';
import 'package:poly_forum/resources/phases_repository.dart';
import 'package:poly_forum/screens/admin/dashboard/components/large_data_tile.dart';
import 'package:poly_forum/screens/admin/dashboard/components/side_panel.dart';
import 'package:poly_forum/utils/constants.dart';

import 'data_tile.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int companiesCount = 0;
  int companyWishesCount = 0;
  int offersCount = 0;
  int companiesWithNoOfferCount = 0;

  int candidatesCount = 0;
  int candidateWishesCount = 0;
  int candidatesWithNoWishCount = 0;
  int cvCount = 0;
  int idleCandidatesCount = 0;
  int incompleteCandidatesCount = 0;
  int completeCandidatesCount = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardCubit>(context).fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
          height: 650,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //     "Tableau de bord",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 40,
                //     )
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: BlocConsumer<DashboardCubit, DashboardState>(
                                  listener: (context, state) {
                                    if (state is DashboardLoaded) {
                                      calculateDashboardData(state);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is DashboardLoading) {
                                      return buildLoadingTiles(context);
                                    } else if (state is DashboardLoaded) {
                                      return buildLoadedTiles(context);
                                    } else if (state is DashboardError) {
                                      return buildErrorTiles(context, state.errorMessage);
                                    } else {
                                      return Container();
                                    }
                                  }
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                            ),
                            Expanded(
                                flex: 1,
                                child: BlocProvider(
                                  create: (context) => SidePanelCubit(PhasesRepository()),
                                  child: const SidePanel(),
                                )
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      );
    });
  }

  buildLoadedTiles(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      DataTile(
                        value: companiesCount,
                        text: "Entreprises",
                        color: kLightGrey,
                      ),
                      DataTile(
                        value: companyWishesCount,
                        text: "Voeux",
                        color: kLightGrey,
                      ),
                      DataTile(
                        value: offersCount,
                        text: "Offres",
                        color: kLightGrey,
                      ),
                      DataTile(
                        value: companiesWithNoOfferCount,
                        text: "Entreprises sans offre",
                        color: kLightGrey,
                      )
                    ]
                )
            ),
            Expanded(
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    DataTile(
                      value: candidatesCount,
                      text: "Candidats",
                      color: kLightBlue,
                    ),
                    DataTile(
                      value: candidateWishesCount,
                      text: "Voeux",
                      color: kLightBlue,
                    ),
                    DataTile(
                      value: cvCount,
                      text: "CVs",
                      color: kLightBlue,
                    ),
                    DataTile(
                      value: candidatesWithNoWishCount,
                      text: "Candidats sans voeux",
                      color: kLightBlue,
                    ),
                    LargeDataTile(
                      width: 310,
                      height: 150,
                      color: kLightBlue,
                      values: [
                        completeCandidatesCount,
                        incompleteCandidatesCount,
                        idleCandidatesCount,
                      ],
                      texts: const [
                        " candidats au profil complet",
                        " candidats au profil incomplet",
                        " candidats jamais connectés",
                      ],
                    )
                  ]
              ),
            ),
          ]
      ),
    );
  }

  buildLoadingTiles(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator()
      ],
    );
  }

  buildErrorTiles(BuildContext context, String errorMessage) {
    return Text(
      errorMessage,
      style: const TextStyle(
          color: Colors.red
      ),
    );
  }

  calculateDashboardData(DashboardLoaded state) {
    companiesCount = state.companies.length;
    companyWishesCount = state.companies
        .map((company) => company.wishesCount)
        .reduce((sum, wishesCount) => sum + wishesCount);
    offersCount = state.companies
        .map((company) => company.offersCount)
        .reduce((sum, offersCount) => sum + offersCount);
    companiesWithNoOfferCount = state.companies
        .where((company) => company.offersCount == 0)
        .length;

    candidatesCount = state.candidates.length;
    candidateWishesCount = state.candidates
        .map((candidates) => candidates.wishesCount)
        .reduce((sum, wishesCount) => sum + wishesCount);
    candidatesWithNoWishCount = state.candidates
        .where((candidate) => candidate.wishesCount == 0)
        .length;
    cvCount = state.candidates
        .where((candidate) => candidate.cv.isNotEmpty)
        .length;
    idleCandidatesCount = state.candidates
        .where((candidate) => candidate.status == "Jamais connecté")
        .length;
    incompleteCandidatesCount = state.candidates
        .where((candidate) => candidate.status == "Incomplet")
        .length;
    completeCandidatesCount = state.candidates
        .where((candidate) => candidate.status == "Complet")
        .length;
  }
}
