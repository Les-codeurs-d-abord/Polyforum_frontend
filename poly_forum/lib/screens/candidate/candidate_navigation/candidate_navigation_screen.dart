import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/screens/candidate/choices/choices_screen.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/planning/planning_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';

import 'components/candidate_profil_btn.dart';
import 'components/tab_navigation_item.dart';

class CandidateNavigationScreen extends StatefulWidget {
  final CandidateUser user;
  const CandidateNavigationScreen({required this.user, Key? key})
      : super(key: key);

  @override
  State<CandidateNavigationScreen> createState() =>
      _CandidateNavigationScreenState();
}

class _CandidateNavigationScreenState extends State<CandidateNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future(() => true);
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: kScaffoldColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Material(
              elevation: 1,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1080) {
                    return buildWebVersion(context);
                  } else {
                    return buildWebVersion(context);
                  }
                },
              ),
            ),
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: const <Widget>[
              WelcomeScreen(),
              OffersScreen(),
              ChoicesScreen(),
              PlanningScreen(),
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
                TabNavigationItem(
                  onPressed: () {
                    setState(
                      () {
                        _selectedIndex = 1;
                      },
                    );
                  },
                  text: "Les offres",
                  isSelect: _selectedIndex == 1,
                ),
                TabNavigationItem(
                  onPressed: () {
                    setState(
                      () {
                        _selectedIndex = 2;
                      },
                    );
                  },
                  text: "Mes choix",
                  isSelect: _selectedIndex == 2,
                ),
                TabNavigationItem(
                  onPressed: () {
                    setState(
                      () {
                        _selectedIndex = 3;
                      },
                    );
                  },
                  text: "Mon planning",
                  isSelect: _selectedIndex == 3,
                ),
              ],
            ),
          ),
        ),
        CandidateProfilBtn(user: widget.user),
      ],
    );
  }
}
