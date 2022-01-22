import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/candidate_nav_bar.dart';
import 'package:poly_forum/screens/candidate/choices/choices_screen.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/profil/candidate_profil_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/tab_navigation_item.dart';

class CandidateNavigationScreen extends StatefulWidget {
  const CandidateNavigationScreen({Key? key}) : super(key: key);

  @override
  State<CandidateNavigationScreen> createState() =>
      _CandidateNavigationScreenState();
}

class _CandidateNavigationScreenState extends State<CandidateNavigationScreen> {
  int _selectedIndex = 0;

  CandidateUser? candidateUser;

  @override
  void initState() {
    super.initState();

    User? currentUser = Application.user;

    if (currentUser == null) {
      SharedPreferences.getInstance().then((value) async {
        try {
          final token = value.getString(kTokenPref);
          if (token != null) {
            final user = await UserRepository().fetchUserFromToken(token);

            if (user is CandidateUser) {
              Application.user = user;
              setState(() {
                candidateUser = user;
              });
            } else {
              Application.router.navigateTo(
                context,
                Routes.signInScreen,
                transition: TransitionType.fadeIn,
              );
            }
          } else {
            Application.router.navigateTo(
              context,
              Routes.signInScreen,
              transition: TransitionType.fadeIn,
            );
          }
        } on Exception catch (e) {
          // print(e.toString());
          Application.router.navigateTo(
            context,
            Routes.signInScreen,
            transition: TransitionType.fadeIn,
          );
        }
      });
    } else {
      if (currentUser is CandidateUser) {
        candidateUser = currentUser;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (candidateUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return WillPopScope(
      onWillPop: () {
        Application.router.navigateTo(
          context,
          Routes.signInScreen,
          clearStack: true,
          transition: TransitionType.fadeIn,
        );
        return Future(() => true);
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.blue[300],
        body: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Image.asset(
                                'images/logo.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 10),
                              Text(
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
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                            isSelect: _selectedIndex == 0,
                            text: "PolyForum",
                            iconData: Icons.local_offer_outlined,
                          ),
                          const SizedBox(height: 20),
                          TabNavigationItem(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                            isSelect: _selectedIndex == 1,
                            text: "Les offres",
                            iconData: Icons.local_offer_outlined,
                          ),
                          const SizedBox(height: 20),
                          TabNavigationItem(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                            isSelect: _selectedIndex == 2,
                            text: "Mes choix",
                            iconData: Icons.local_offer_outlined,
                          ),
/*                           const SizedBox(height: 20),
                          TabNavigationItem(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                            },
                            isSelect: _selectedIndex == 3,
                            text: "Mon planning",
                            iconData: Icons.local_offer_outlined,
                          ), */
                          const SizedBox(height: 20),
                          TabNavigationItem(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                            },
                            isSelect: _selectedIndex == 3,
                            text: "Mon profil",
                            iconData: Icons.local_offer_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 70),
                          Expanded(
                            child: IndexedStack(
                              index: _selectedIndex,
                              children: <Widget>[
                                const WelcomeScreen(),
                                const OffersScreen(),
                                const ChoicesScreen(),
                                /* PlanningScreen(user: candidateUser!), */
                                CandidateProfilScreen(
                                    candidateUser: candidateUser!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CandidateNavBar(
                      user: candidateUser!,
                      onProfileSelected: () {
                        setState(() {
                          _selectedIndex = 4;
                        });
                      },
                      paths: ["Profil", "Test", "oui"],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
