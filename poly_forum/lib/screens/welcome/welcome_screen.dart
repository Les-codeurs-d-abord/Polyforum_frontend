import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/cubit/welcome_screen_cubit.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/screens/welcome/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  static const route = "/";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: BlocProvider(
        create: (context) => WelcomeScreenCubit(UserRepository()),
        child: const Body(),
      ),
    );
  }
}
