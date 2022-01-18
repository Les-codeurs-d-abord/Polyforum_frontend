import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/candidate_navigation_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    var routeName = settings.name ?? "";
    switch (routeName) {
      case Routes.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.candidatScreen:
        const test = CandidateUser(
          address: "",
          description: "",
          email: "",
          firstName: "",
          lastName: "",
          phoneNumber: "",
          role: "",
          id: -1,
        );
        return MaterialPageRoute(
            builder: (_) => const CandidateNavigationScreen(user: test));
      default:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
    }
  }
}

// ignore: unused_element
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
