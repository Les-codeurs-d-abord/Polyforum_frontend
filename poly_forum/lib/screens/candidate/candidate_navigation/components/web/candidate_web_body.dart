import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/planning/planning_screen.dart';
import 'package:poly_forum/screens/candidate/profil/edit/candidate_profil_screen.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/candidate/wishlist/choices_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tab_navigation_item_list.dart';
import 'candidate_nav_bar.dart';

class CandidateWebBody extends StatelessWidget {
  const CandidateWebBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateNavigationCubit, CandidateNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CandidateNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
            BlocProvider.of<CandidateGetUserCubit>(context).getUser(),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(
      BuildContext context, int selectedIndex, CandidateUser candidateUser) {
    return Scaffold(
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
                                    OffersScreen(user: candidateUser),
                                    ChoicesScreen(user: candidateUser),
                                    PlanningScreen(user: candidateUser),
                                    HomeProfileScreen(
                                      onEditProfilePressed: () {
                                        BlocProvider.of<
                                                    CandidateNavigationCubit>(
                                                context)
                                            .setSelectedItem(5);
                                      },
                                      onChangePasswordPressed: () {
                                        BlocProvider.of<
                                                    CandidateNavigationCubit>(
                                                context)
                                            .setSelectedItem(6);
                                      },
                                    ),
                                    CandidateProfilScreen(
                                        candidateUser: candidateUser),
                                    ChangePasswordScreen(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CandidateNavBar(
                          user: candidateUser,
                          onProfileSelected: () {
                            BlocProvider.of<CandidateNavigationCubit>(context)
                                .setSelectedItem(4);
                          },
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
    );
  }

  String getTitle(int selectedIndex) {
    String title = "";

    switch (selectedIndex) {
      case 0:
        title = "Le forum";
        break;
      case 1:
        title = "Les offres proposées";
        break;
      case 2:
        title = "Organisation des voeux";
        break;
      case 3:
        title = "Mon profil";
        break;
      case 4:
        title = "Mon planning";
        break;
      case 5:
        title = "Modifier mon profil";
        break;
      case 6:
        title = "Changer le mot de passe";
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
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(0);
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
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(1);
            },
            child: const Text(
              "Les offres",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 2:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(2);
            },
            child: const Text(
              "Mes choix",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 3:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(3);
            },
            child: const Text(
              "Mon planning",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 4:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(3);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 5:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(4);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(5);
            },
            child: const Text(
              "Modifier mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 6:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(4);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(6);
            },
            child: const Text(
              "Changer mon mot de passe",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
    }
    return breadcrumbs;
  }
}
