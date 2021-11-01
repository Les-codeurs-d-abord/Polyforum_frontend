import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
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
        } else if (state is SignInScreenLoaded) {
          Navigator.of(context).pushNamed(HomeScreen.route);
        }
      },
      builder: (context, state) {
        if (state is SignInScreenLoading) {
          return buildLoading();
        } else {
          return buildInitialScreen(context);
        }
      },
    );
  }

  Widget buildInitialScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                "images/logo_temp.png",
                width: 500,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: const Center(
              child: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: Card(
                    child: SignForm(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
