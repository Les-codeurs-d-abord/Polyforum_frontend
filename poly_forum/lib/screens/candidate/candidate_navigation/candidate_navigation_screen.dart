import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/screens/candidate/choices/choices_screen.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/planning/planning_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/candidate_profil_btn.dart';
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
          backgroundColor: kScaffoldColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leading: Image.asset("images/logo.jpg"),
              title: const Text(
                "Candidat",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                CandidateProfilBtn(user: candidateUser!),
              ],
            ),
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      color: Colors.orange[400],
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 20),
                            TabNavigationItem(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                              },
                              isSelect: _selectedIndex == 3,
                              text: "Mon planning",
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
                child: IndexedStack(
                  index: _selectedIndex,
                  children: const <Widget>[
                    WelcomeScreen(),
                    OffersScreen(),
                    ChoicesScreen(),
                    PlanningScreen(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildWebVersion(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: Container(
            width: 150,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "PolyForum",
              style: GoogleFonts.pacifico(fontSize: 30),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: VerticalDivider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            primary: false,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // TabNavigationItem(
                //   onPressed: () {
                //     setState(
                //       () {
                //         _selectedIndex = 1;
                //       },
                //     );
                //   },
                //   text: "Les offres",
                //   isSelect: _selectedIndex == 1,
                // ),
                // TabNavigationItem(
                //   onPressed: () {
                //     setState(
                //       () {
                //         _selectedIndex = 2;
                //       },
                //     );
                //   },
                //   text: "Mes choix",
                //   isSelect: _selectedIndex == 2,
                // ),
                // TabNavigationItem(
                //   onPressed: () {
                //     setState(
                //       () {
                //         _selectedIndex = 3;
                //       },
                //     );
                //   },
                //   text: "Mon planning",
                //   isSelect: _selectedIndex == 3,
                // ),
              ],
            ),
          ),
        ),
        CandidateProfilBtn(user: candidateUser!),
      ],
    );
  }
}
