import 'package:flutter/material.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:poly_forum/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poly Forum',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: theme(),
      routes: {
        WelcomeScreen.route: (context) => const WelcomeScreen(),
        SignInScreen.route: (context) => const SignInScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
      },
    );
  }
}
