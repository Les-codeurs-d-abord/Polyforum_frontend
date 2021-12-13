import 'package:flutter/cupertino.dart';
import 'package:poly_forum/routes/routes_name.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var routeName = settings.name ?? "";
    switch (settings.name) {
      case RoutesName.SIGN_IN_SCREEN:
        return _GeneratePageRoute(
            widget: const SignInScreen(), routeName: routeName);
      case RoutesName.PROFIL_CANDIDAT_SCREEN:
        return _GeneratePageRoute(
            widget: const HomeScreen(), routeName: routeName);

      default:
        return _GeneratePageRoute(
            widget: const SignInScreen(), routeName: routeName);
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
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
