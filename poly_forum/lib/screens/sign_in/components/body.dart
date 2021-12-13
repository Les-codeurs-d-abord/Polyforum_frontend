import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/constants.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
import 'package:poly_forum/routes/routes_name.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/components/sign_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInScreenCubit, SignInScreenState>(
      listener: (context, state) {
        if (state is SignInScreenError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is SignInScreenInvalidUserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is SignInScreenLoaded) {
          // Navigator.pushNamed(context, RoutesName.PROFIL_CANDIDAT_SCREEN);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        }
      },
      builder: (context, state) {
        if (state is SignInScreenLoading) {
          return buildInitialScreen(context, true);
        } else {
          return buildInitialScreen(context, false);
        }
      },
    );
  }

  Widget buildInitialScreen(BuildContext context, bool isLoading) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1080) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 800,
                child: SingleChildScrollView(
                  child: SignForm(isLoading),
                ),
              ),
              Expanded(
                child: Container(
                  color: kSecondaryColor,
                  child: Center(
                    child: Image.asset(
                      "images/interview_1.png",
                      width: 700,
                      height: 700,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Expanded(
            child: Container(
              height: double.infinity,
              color: kScaffoldColor,
              child: SingleChildScrollView(
                child: SignForm(isLoading),
              ),
            ),
          );
        }
      },
    );
  }
}
