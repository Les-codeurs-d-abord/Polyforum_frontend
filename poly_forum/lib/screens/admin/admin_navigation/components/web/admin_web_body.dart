import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_get_user_cubit.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_navigation_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/admin/admin_navigation/tab_navigation_item_list.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/admin/dashboard/dashboard_screen.dart';
import 'package:poly_forum/screens/admin/planning/home/home_planning_screen.dart';
import 'package:poly_forum/screens/admin/planning/planning_candidates_screen.dart';
import 'package:poly_forum/screens/admin/planning/planning_companies_screen.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_nav_bar.dart';

class AdminWebBody extends StatelessWidget {
  const AdminWebBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminNavigationCubit, AdminNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AdminNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
            BlocProvider.of<AdminGetUserCubit>(context).getUser(),
          );
        }
        return Container();
      },
    );
  }

  Widget buildScreen(
      BuildContext context, int selectedIndex, AdminUser adminUser) {
    return BlocListener<PhaseCubit, PhaseState>(
      listener: (context, state) {
        if (state is PhaseLoaded) {
          BlocProvider.of<AdminNavigationCubit>(context).refreshSelectedItem();
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    primary: false,
                    child: TabNavigationItemList(selectedIndex: selectedIndex),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(height: 70),
                                Expanded(
                                  child: IndexedStack(
                                    index: selectedIndex,
                                    children: <Widget>[
                                      const WelcomeScreen(),
                                      const DashboardScreen(),
                                      const CompanyListScreen(),
                                      const CandidateListScreen(),
                                      HomePlanningScreen(
                                        onCompanyPlanningPressed: () {
                                          BlocProvider.of<AdminNavigationCubit>(
                                                  context)
                                              .setSelectedItem(5);
                                        },
                                        onCandidatePlanningPressed: () {
                                          BlocProvider.of<AdminNavigationCubit>(
                                                  context)
                                              .setSelectedItem(6);
                                        },
                                      ),
                                      const PlanningCompaniesScreen(),
                                      const PlanningCandidatesScreen(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AdminNavBar(
                            user: adminUser,
                            paths: buildBreadcrumbs(context, selectedIndex),
                            title: getTitle(selectedIndex),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTitle(int selectedIndex) {
    String title = "";

    switch (selectedIndex) {
      case 0:
        title = "Le forum";
        break;
      case 1:
        title = "Tableau de bord";
        break;
      case 2:
        title = "Liste des entreprises";
        break;
      case 3:
        title = "Liste des candidats";
        break;
      case 4:
        title = "Accès aux plannings";
        break;
      case 5:
        title = "Planning des entreprises";
        break;
      case 6:
        title = "Planning des candidats";
        break;
    }

    return title;
  }

  List<Widget> buildBreadcrumbs(BuildContext context, int selectedIndex) {
    List<Widget> breadcrumbs = [];

    switch (selectedIndex) {
      case 0:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(0);
            },
            child: const Text(
              "Le forum",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 1:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(1);
            },
            child: const Text(
              "Tableau de bord",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 2:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(2);
            },
            child: const Text(
              "Entreprises",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 3:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(3);
            },
            child: const Text(
              "Candidats",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 4:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(4);
            },
            child: const Text(
              "Planning",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 5:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(4);
            },
            child: const Text(
              "Planning",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(5);
            },
            child: const Text(
              "Entreprises",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 6:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(4);
            },
            child: const Text(
              "Planning",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(6);
            },
            child: const Text(
              "Candidats",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
    }
    return breadcrumbs;
  }
}
