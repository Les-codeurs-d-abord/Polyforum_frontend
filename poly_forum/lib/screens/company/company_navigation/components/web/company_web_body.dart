import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/company/candidat/list/candidat_list.dart';
import 'package:poly_forum/screens/company/company_navigation/components/tab_navigation_item_list.dart';
import 'package:poly_forum/screens/company/offers/create/create_offer_screen.dart';
import 'package:poly_forum/screens/company/offers/get/offers_screen.dart';
import 'package:poly_forum/screens/company/planning/planning_screen.dart';
import 'package:poly_forum/screens/company/profile/edit/company_profil_screen.dart';
import 'package:poly_forum/screens/company/wishlist/wishlist_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'company_nav_bar.dart';

class CompanyWebBody extends StatelessWidget {
  const CompanyWebBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyNavigationCubit, CompanyNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CompanyNavigationLoaded) {
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
                                    const OffersScreen(),
                                    const CreateOfferScreen(),
                                    const CandidatList(),
                                    const WishlistScreen(),
                                    const PlanningScreen(),
                                    HomeProfileScreen(
                                      onEditProfilePressed: () {
                                        BlocProvider.of<CompanyNavigationCubit>(
                                                context)
                                            .setSelectedItem(7);
                                      },
                                      onChangePasswordPressed: () {
                                        BlocProvider.of<CompanyNavigationCubit>(
                                                context)
                                            .setSelectedItem(8);
                                      },
                                    ),
                                    const CompanyProfileScreen(), //profil
                                    ChangePasswordScreen(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CompanyNavBar(
                          onProfileSelected: () {
                            BlocProvider.of<CompanyNavigationCubit>(context)
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
        title = "Mes offres";
        break;
      case 2:
        title = "Créer une offre";
        break;
      case 3:
        title = "Liste des candidats";
        break;
      case 4:
        title = "Mes voeux";
        break;
      case 5:
        title = "Mon planning";
        break;
      case 6:
        title = "Mon profil";
        break;
      case 7:
        title = "Modifier mon profil";
        break;
      case 8:
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
              BlocProvider.of<CompanyNavigationCubit>(context)
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
              BlocProvider.of<CompanyNavigationCubit>(context)
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
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(1);
            },
            child: const Text(
              "Les offres",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(2);
            },
            child: const Text(
              "Créer une offre",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 3:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(3);
            },
            child: const Text(
              "Les candidats",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 4:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(4);
            },
            child: const Text(
              "Mes voeux",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 5:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(5);
            },
            child: const Text(
              "Mon planning",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 6:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(6);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 7:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(7);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(7);
            },
            child: const Text(
              "Modifier mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
      case 8:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(6);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(8);
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
