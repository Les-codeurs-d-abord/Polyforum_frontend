import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_cubit.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/candidate_nav_bar.dart';
import 'package:poly_forum/screens/candidate/profil/edit/candidate_profil_screen.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/screens/candidate/wishlist/choices_screen.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'candidate_profil_btn.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _selectedIndex = 0;
  List<Widget> breadcrumbs = [];
  CandidateUser? candidateUser;

  @override
  void initState() {
    super.initState();
    User? currentUser;

    if (currentUser == null) {
      SharedPreferences.getInstance().then((value) async {
        try {
          final token = value.getString(kTokenPref);
          if (token != null) {
            final user = await UserRepository().fetchUserFromToken(token);

            if (user is CandidateUser) {
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

    buildBreadcrumbs();

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CandidateChoicesCubit(),
          ),
          BlocProvider(
            create: (context) => CandidateOfferScreenCubit(),
          ),
        ],
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1024) {
            return buildWebScreen();
          } else {
            return buildPhoneVersion();
          }
        }),
      ),
    );
  }

  Widget buildPhoneVersion() {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          primary: false,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // decoration: const BoxDecoration(
              //   color: kSecondaryColor,
              // ),
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(height: 20),
            TabNavigationItem(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                  Navigator.pop(context);
                });
              },
              isSelect: _selectedIndex == 0,
              text: "Le forum",
              iconData: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            const SizedBox(height: 20),
            TabNavigationItem(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                  Navigator.pop(context);
                });
              },
              isSelect: _selectedIndex == 1,
              text: "Les offres",
              iconData: _selectedIndex == 1
                  ? Icons.local_offer
                  : Icons.local_offer_outlined,
            ),
            const SizedBox(height: 20),
            TabNavigationItem(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                  Navigator.pop(context);
                });
              },
              isSelect: _selectedIndex == 2,
              text: "Mes choix",
              iconData:
                  _selectedIndex == 2 ? Icons.bookmark : Icons.bookmark_border,
            ),
            const SizedBox(height: 20),
            TabNavigationItem(
              onPressed: () {
                setState(() {
                  _selectedIndex = 4;
                  Navigator.pop(context);
                });
              },
              isSelect: _selectedIndex >= 4,
              text: "Mon profil",
              iconData:
                  _selectedIndex >= 4 ? Icons.person : Icons.person_outline,
              children: [
                TabChildNavigationItem(
                  title: "Modifier mon profil",
                  onPress: () {
                    setState(() {
                      _selectedIndex = 5;
                      Navigator.pop(context);
                    });
                  },
                  isSelect: _selectedIndex == 5,
                ),
                TabChildNavigationItem(
                  title: "Changer mon mot de passe",
                  onPress: () {
                    setState(() {
                      _selectedIndex = 6;
                      Navigator.pop(context);
                    });
                  },
                  isSelect: _selectedIndex == 6,
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // title: Row(
        //   children: [
        //     for (int i = 0; i < breadcrumbs.length; i++)
        //       Row(
        //         children: [
        //           breadcrumbs[i],
        //           i < breadcrumbs.length - 1
        //               ? const Icon(Icons.arrow_right)
        //               : const SizedBox.shrink(),
        //         ],
        //       ),
        //   ],
        // ),
        title: const Text(
          "PolyForum",
          style: TextStyle(color: Colors.black),
        ),
        // leading: Image.asset(
        //   'images/logo.png',
        //   width: 80,
        //   height: 80,
        //   fit: BoxFit.contain,
        // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          CandidateProfilBtn(
            user: candidateUser!,
            onProfileSelected: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                const WelcomeScreen(),
                OffersScreen(user: candidateUser!),
                ChoicesScreen(user: candidateUser!),
                /* PlanningScreen(user: candidateUser!), */
                Container(),
                HomeProfileScreen(
                  onEditProfilePressed: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                  onChangePasswordPressed: () {
                    setState(() {
                      _selectedIndex = 6;
                    });
                  },
                ),
                CandidateProfilScreen(candidateUser: candidateUser!),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebScreen() {
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
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        isSelect: _selectedIndex == 0,
                        text: "Le forum",
                        iconData: _selectedIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
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
                        iconData: _selectedIndex == 1
                            ? Icons.local_offer
                            : Icons.local_offer_outlined,
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
                        iconData: _selectedIndex == 2
                            ? Icons.bookmark
                            : Icons.bookmark_border,
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
                            _selectedIndex = 4;
                          });
                        },
                        isSelect: _selectedIndex >= 4,
                        text: "Mon profil",
                        iconData: _selectedIndex >= 4
                            ? Icons.person
                            : Icons.person_outline,
                        children: [
                          TabChildNavigationItem(
                            title: "Modifier mon profil",
                            onPress: () {
                              setState(() {
                                _selectedIndex = 5;
                              });
                            },
                            isSelect: _selectedIndex == 5,
                          ),
                          TabChildNavigationItem(
                            title: "Changer mon mot de passe",
                            onPress: () {
                              setState(() {
                                _selectedIndex = 6;
                              });
                            },
                            isSelect: _selectedIndex == 6,
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
                                  index: _selectedIndex,
                                  children: <Widget>[
                                    const WelcomeScreen(),
                                    OffersScreen(user: candidateUser!),
                                    ChoicesScreen(user: candidateUser!),
                                    /* PlanningScreen(user: candidateUser!), */
                                    Container(),
                                    HomeProfileScreen(
                                      onEditProfilePressed: () {
                                        setState(() {
                                          _selectedIndex = 5;
                                        });
                                      },
                                      onChangePasswordPressed: () {
                                        setState(() {
                                          _selectedIndex = 6;
                                        });
                                      },
                                    ),
                                    CandidateProfilScreen(
                                        candidateUser: candidateUser!),
                                    Container(),
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
                          paths: breadcrumbs,
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

  void buildBreadcrumbs() {
    switch (_selectedIndex) {
      case 0:
        breadcrumbs = [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
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
              setState(() {
                _selectedIndex = 1;
              });
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
              setState(() {
                _selectedIndex = 2;
              });
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
              setState(() {
                _selectedIndex = 3;
              });
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
              setState(() {
                _selectedIndex = 3;
              });
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
              setState(() {
                _selectedIndex = 4;
              });
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 5;
              });
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
              setState(() {
                _selectedIndex = 4;
              });
            },
            child: const Text(
              "Mon profil",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 6;
              });
            },
            child: const Text(
              "Changer mon mot de passe",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        ];
        break;
    }
  }
}
