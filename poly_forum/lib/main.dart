import 'package:flutter/material.dart';
import 'package:poly_forum/routes/route_generator.dart';
import 'package:poly_forum/routes/routes_name.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/home_page.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/themes.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poly Forum',
      theme: theme(),
      // builder: (context, child) => HomePage(child: child!),
      // onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: RoutesName.SIGN_IN_SCREEN,
      home: const HomeScreen(),
    );
  }
}
