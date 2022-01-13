import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/routes/routes_name.dart';
import 'package:poly_forum/screens/admin/candidate_list/candidate_list_screen.dart';
import 'package:poly_forum/screens/admin/company_list/company_list_screen.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/candidate_navigation_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    var routeName = settings.name ?? "";
    switch (routeName) {
      case RoutesName.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      // case RoutesName.candidatScreen:
      //   return MaterialPageRoute(
      //       builder: (_) => const CandidateNavigationScreen());
      case RoutesName.companyListScreen:
        return MaterialPageRoute(builder: (_) => const CompanyListScreen());
      case RoutesName.candidateListScreen:
        return MaterialPageRoute(builder: (_) => const CandidateListScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
