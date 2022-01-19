import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/route_generator.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/candidate_navigation_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:poly_forum/utils/custom_scroll_behavior.dart';
import 'package:poly_forum/utils/themes.dart';
import 'package:url_strategy/url_strategy.dart';

import 'data/models/candidate_user_model.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Poly Forum',
      theme: theme(),
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.signInScreen,
      home: const SignInScreen(),
    );
  }
}
