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
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/admin/dashboard/dashboard_screen.dart';
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
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(
                              'images/logo.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "PolyForum",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TabNavigationItem(
                          onPressed: () {
                            BlocProvider.of<AdminNavigationCubit>(context)
                                .setSelectedItem(0);
                          },
                          isSelect: selectedIndex == 0,
                          text: "Le forum",
                          iconData: selectedIndex == 0
                              ? Icons.home
                              : Icons.home_outlined,
                        ),
                        TabNavigationItem(
                          onPressed: () {
                            BlocProvider.of<AdminNavigationCubit>(context)
                                .setSelectedItem(1);
                          },
                          isSelect: selectedIndex == 1,
                          text: "Tableau de bord",
                          iconData: Icons.space_dashboard,
                        ),
                        TabNavigationItem(
                          onPressed: () {
                            BlocProvider.of<AdminNavigationCubit>(context)
                                .setSelectedItem(2);
                          },
                          isSelect: selectedIndex == 2,
                          text: "Entreprises",
                          iconData: Icons.business,
                        ),
                        TabNavigationItem(
                          onPressed: () {
                            BlocProvider.of<AdminNavigationCubit>(context)
                                .setSelectedItem(3);
                          },
                          isSelect: selectedIndex == 3,
                          text: "Candidats",
                          iconData: Icons.school,
                        ),
                        TabNavigationItem(
                          onPressed: () {
                            BlocProvider.of<AdminNavigationCubit>(context)
                                .setSelectedItem(4);
                          },
                          isSelect: selectedIndex >= 4,
                          text: "Planning",
                          iconData: selectedIndex >= 4
                              ? Icons.today
                              : Icons.today_outlined,
                          children: [
                            TabChildNavigationItem(
                              title: "Candidats",
                              onPress: () {
                                BlocProvider.of<AdminNavigationCubit>(context)
                                    .setSelectedItem(5);
                              },
                              isSelect: selectedIndex == 5,
                            ),
                            TabChildNavigationItem(
                              title: "Entreprises",
                              onPress: () {
                                BlocProvider.of<AdminNavigationCubit>(context)
                                    .setSelectedItem(6);
                              },
                              isSelect: selectedIndex == 6,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                      Container(),
                                      const PlanningCandidatesScreen(),
                                      const PlanningCompaniesScreen(),
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
            Positioned(
              bottom: 1,
              left: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 50),
                child: TextButton(
                  onPressed: () {
                    SharedPreferences.getInstance()
                        .then((value) => value.setString(kTokenPref, ""));
                    Application.router.navigateTo(
                      context,
                      Routes.signInScreen,
                      clearStack: true,
                      transition: TransitionType.fadeIn,
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Se déconnecter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        title = "Les entreprises";
        break;
      case 3:
        title = "Les candidats";
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
              "Les entreprises",
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
              "Les candidats",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
    }
    return breadcrumbs;
  }
}
