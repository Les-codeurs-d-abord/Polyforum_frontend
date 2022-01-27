import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/company/offers/create/create_offer_screen.dart';
import 'package:poly_forum/screens/company/offers/offers_screen.dart';
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
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
                        index: 0,
                        selectedIndex: selectedIndex,
                        text: "Le forum",
                        iconSelected: Icons.home,
                        iconNonSelected: Icons.home_outlined,
                      ),
                      const SizedBox(height: 20),
                      TabNavigationItem(
                        index: 1,
                        selectedIndex: selectedIndex,
                        text: "Mes offres",
                        iconSelected: Icons.local_offer,
                        iconNonSelected: Icons.local_offer_outlined,
                        children: [
                          TabChildNavigationItem(
                            index: 2,
                            selectedIndex: selectedIndex,
                            text: "Créer une offre",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TabNavigationItem(
                        index: 3,
                        selectedIndex: selectedIndex,
                        text: "Les candidats",
                        iconSelected: Icons.local_offer,
                        iconNonSelected: Icons.local_offer_outlined,
                      ),
                      const SizedBox(height: 20),
                      TabNavigationItem(
                        index: 5,
                        selectedIndex: selectedIndex,
                        text: "Mon profil",
                        iconSelected: Icons.person,
                        iconNonSelected: Icons.person_outline,
                        children: [
                          TabChildNavigationItem(
                            index: 6,
                            selectedIndex: selectedIndex,
                            text: "Modifier mon profil",
                          ),
                          TabChildNavigationItem(
                            index: 7,
                            selectedIndex: selectedIndex,
                            text: "Changer mon mot de passe",
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
                                    const OffersScreen(),
                                    const CreateOfferScreen(),
                                    Container(), //candidat
                                    Container(), //planning
                                    HomeProfileScreen(
                                      onEditProfilePressed: () {
                                        BlocProvider.of<CompanyNavigationCubit>(
                                                context)
                                            .setSelectedItem(6);
                                      },
                                      onChangePasswordPressed: () {
                                        BlocProvider.of<CompanyNavigationCubit>(
                                                context)
                                            .setSelectedItem(7);
                                      },
                                    ),
                                    Container(), //profil
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
        title = "List des candidats";
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
              BlocProvider.of<CompanyNavigationCubit>(context)
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
              BlocProvider.of<CompanyNavigationCubit>(context)
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
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(4);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
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
              BlocProvider.of<CompanyNavigationCubit>(context)
                  .setSelectedItem(4);
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<CompanyNavigationCubit>(context)
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
