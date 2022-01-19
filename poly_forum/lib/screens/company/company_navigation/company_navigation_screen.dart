import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/company/planning/planning_screen.dart';
import 'package:poly_forum/screens/shared/components/profil_btn.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/screens/company/company_navigation/components/tab_navigation_item.dart';

class CompanyNavigationScreen extends StatefulWidget {
  final CompanyUser user;

  const CompanyNavigationScreen({required this.user, Key? key})
      : super(key: key);

  @override
  State<CompanyNavigationScreen> createState() =>
      _CompanyNavigationScreenState();
}

class _CompanyNavigationScreenState extends State<CompanyNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            children: <Widget>[
              const WelcomeScreen(),
              PlanningScreen(
                user: widget.user,
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
                  text: "Mon planning",
                  isSelect: _selectedIndex == 1,
                ),
              ],
            ),
          ),
        ),
        ProfilBtn(
          name: widget.user.companyName,
          email: widget.user.email,
        ),
      ],
    );
  }
}
