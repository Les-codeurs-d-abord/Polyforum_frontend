import 'package:flutter/material.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';

import 'components/profil_btn.dart';
import 'components/tab_navigation_item.dart';

class CompanyNavigationScreen extends StatefulWidget {
  const CompanyNavigationScreen({Key? key}) : super(key: key);

  @override
  State<CompanyNavigationScreen> createState() =>
      _CompanyNavigationScreenState();
}

class _CompanyNavigationScreenState extends State<CompanyNavigationScreen> {
  int _selectedIndex = 1;

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
              CompanyListScreen(),
              CandidateListScreen(),
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
                  text: "(Admin) Entreprises",
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
                  text: "(Admin) Candidats",
                  isSelect: _selectedIndex == 2,
                ),
              ],
            ),
          ),
        ),
        const ProfilBtn(),
      ],
    );
  }
}
