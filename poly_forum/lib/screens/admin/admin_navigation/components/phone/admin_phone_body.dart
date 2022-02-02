import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_get_user_cubit.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_navigation_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/admin/dashboard/dashboard_screen.dart';
import 'package:poly_forum/screens/admin/planning/home/home_planning_screen.dart';
import 'package:poly_forum/screens/admin/planning/planning_candidates_screen.dart';
import 'package:poly_forum/screens/admin/planning/planning_companies_screen.dart';
import 'package:poly_forum/screens/shared/components/nav_bar_profil_btn.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tab_navigation_item_list.dart';
import '../admin_profil_btn.dart';

class AdminPhoneBody extends StatelessWidget {
  const AdminPhoneBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminNavigationCubit, AdminNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AdminNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(BuildContext context, int selectedIndex) {
    final AdminUser user =
        BlocProvider.of<AdminGetUserCubit>(context).getUser();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          primary: false,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
            TabNavigationItemList(selectedIndex: selectedIndex),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          getTitle(selectedIndex),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          AdminProfilBtn(
            user: user,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: <Widget>[
                WelcomeScreen(
                    user: BlocProvider.of<AdminGetUserCubit>(context).user),
                const DashboardScreen(),
                const CompanyListScreen(),
                const CandidateListScreen(),
                HomePlanningScreen(
                  onCompanyPlanningPressed: () {
                    BlocProvider.of<AdminNavigationCubit>(context)
                        .setSelectedItem(5);
                  },
                  onCandidatePlanningPressed: () {
                    BlocProvider.of<AdminNavigationCubit>(context)
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
}
