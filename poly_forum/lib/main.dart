import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/candidate_navigation_screen.dart';
import 'package:poly_forum/utils/custom_scroll_behavior.dart';
import 'package:poly_forum/utils/themes.dart';
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
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Poly Forum',
      theme: theme(),
      // onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: RoutesName.signInScreen,
      home: const CandidateNavigationScreen(),
    );
  }
}
