import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/admin/dashboard/dashboard_screen.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'admin_nav_bar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 1;

  AdminUser? adminUser;

  @override
  void initState() {
    super.initState();

    User? currentUser;

    BlocProvider.of<PhaseCubit>(context).fetchCurrentPhase();

    // if (currentUser == null) {
    //   SharedPreferences.getInstance().then((value) async {
    //     try {
    //       final token = value.getString(kTokenPref);
    //       if (token != null) {
    //         final user = await UserRepository().fetchUserFromToken(token);
    //
    //         if (user is AdminUser) {
    //           setState(() {
    //             adminUser = user;
    //           });
    //         } else {
    //           Application.router.navigateTo(
    //             context,
    //             Routes.signInScreen,
    //             transition: TransitionType.fadeIn,
    //           );
    //         }
    //       } else {
    //         Application.router.navigateTo(
    //           context,
    //           Routes.signInScreen,
    //           transition: TransitionType.fadeIn,
    //         );
    //       }
    //     } on Exception catch (e) {
    //       // print(e.toString());
    //       Application.router.navigateTo(
    //         context,
    //         Routes.signInScreen,
    //         transition: TransitionType.fadeIn,
    //       );
    //     }
    //   });
    // } else {
    //   if (currentUser is AdminUser) {
    //     adminUser = currentUser;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (adminUser == null) {
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
        body: BlocConsumer<PhaseCubit, PhaseState>(
            listener: (context, state) {
              if (state is PhaseError) {
                showTopSnackBar(
                  context,
                  Padding(
                    padding: kTopSnackBarPadding,
                    child: CustomSnackBar.error(
                      message: state.errorMessage,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is PhaseLoading || state is PhaseError) {
                return buildWebScreen(context, isLoading: true);
              } else if (state is PhaseLoaded) {
                return buildWebScreen(context, isLoading: false);
              } else {
                return Container();
              }
            }
        ),
      ),
    );
  }

  Widget buildWebScreen(BuildContext context, {isLoading = false}) {
    return Row(
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
                      isLoading ?
                      const CircularProgressIndicator() :
                      Column(
                        children: [
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
                            text: "Tableau de bord",
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
                            text: "Entreprises",
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
                            text: "Candidats",
                            iconData: Icons.local_offer_outlined,
                          ),
                        ],
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
                        child: isLoading ?
                        Container() :
                        IndexedStack(
                          index: _selectedIndex,
                          children: const <Widget>[
                            WelcomeScreen(),
                            DashboardScreen(),
                            CompanyListScreen(),
                            CandidateListScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AdminNavBar(
                  user: adminUser!,
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
    );
  }
}
