import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
import 'package:poly_forum/resources/repository.dart';
import 'package:poly_forum/screens/sign_in/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        body: BlocProvider(
          create: (context) => SignInScreenCubit(Repository()),
          child: const Body(),
        ),
      ),
    );
  }
}
