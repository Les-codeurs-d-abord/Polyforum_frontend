import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/shared/components/tab_navigation_item.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/admin_nav_bar.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  State<AdminNavigationScreen> createState() => _AdminNavigationScreenState();
}

class _AdminNavigationScreenState extends State<AdminNavigationScreen> {
  int _selectedIndex = 1;

  AdminUser? adminUser;

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

            if (user is AdminUser) {
              Application.user = user;
              setState(() {
                adminUser = user;
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
      if (currentUser is AdminUser) {
        adminUser = currentUser;
      }
    }
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
                            text: "Entreprises",
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
                            text: "Candidats",
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
                                const CompanyListScreen(),
                                const CandidateListScreen(),
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
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //       onWillPop: () {
  //         Application.router.navigateTo(
  //           context,
  //           Routes.signInScreen,
  //           clearStack: true,
  //           transition: TransitionType.fadeIn,
  //         );
  //         return Future(() => true);
  //       },
  //       child: Scaffold(
  //         extendBody: true,
  //         backgroundColor: kScaffoldColor,
  //         appBar: PreferredSize(
  //           preferredSize: const Size.fromHeight(70),
  //           child: Material(
  //             elevation: 1,
  //             child: LayoutBuilder(
  //               builder: (context, constraints) {
  //                 if (constraints.maxWidth > 1080) {
  //                   return buildWebVersion(context);
  //                 } else {
  //                   return buildWebVersion(context);
  //                 }
  //               },
  //             ),
  //           ),
  //         ),
  //         body: IndexedStack(
  //           index: _selectedIndex,
  //           children: const <Widget>[
  //             WelcomeScreen(),
  //             CompanyListScreen(),
  //             CandidateListScreen(),
  //           ],
  //         ),
  //       ));
  // }
  //
  // Widget buildWebVersion(BuildContext context) {
  //   return Row(
  //     children: [
  //       MaterialButton(
  //         onPressed: () {
  //           setState(() {
  //             _selectedIndex = 0;
  //           });
  //         },
  //         child: Container(
  //           width: 150,
  //           height: double.infinity,
  //           alignment: Alignment.center,
  //           child: Text(
  //             "PolyForum",
  //             style: GoogleFonts.pacifico(fontSize: 30),
  //           ),
  //         ),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: VerticalDivider(
  //           thickness: 1,
  //         ),
  //       ),
  //       Expanded(
  //         child: SizedBox(
  //           width: 300,
  //           child: SingleChildScrollView(
  //             primary: false,
  //             scrollDirection: Axis.horizontal,
  //             child: Row(
  //               children: [
  //                 TabNavigationItem(
  //                   onPressed: () {
  //                     setState(
  //                       () {
  //                         _selectedIndex = 1;
  //                       },
  //                     );
  //                   },
  //                   text: "(Admin) Entreprises",
  //                   isSelect: _selectedIndex == 1,
  //                   iconData: Icons.home,
  //                 ),
  //                 TabNavigationItem(
  //                   onPressed: () {
  //                     setState(
  //                       () {
  //                         _selectedIndex = 2;
  //                       },
  //                     );
  //                   },
  //                   text: "(Admin) Candidats",
  //                   isSelect: _selectedIndex == 2,
  //                   iconData: Icons.home,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       // CandidateProfilBtn(
  //       //   email: widget.user.email,
  //       //   name: "Admin",
  //       // ),
  //     ],
  //   );
  // }
}
