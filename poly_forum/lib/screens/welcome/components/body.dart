import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/welcome_screen_cubit.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeScreenCubit, WelcomeScreenState>(
      listener: (context, state) {
        if (state is WelcomeScreenError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is WelcomeScreenLoaded) {
          Navigator.of(context).pushNamed(HomeScreen.route);
        } else if (state is WelcomeScreenUserUnfound) {
          Navigator.of(context).pushNamed(SignInScreen.route);
        }
      },
      builder: (context, state) {
        if (state is WelcomeScreenLoading) {
          return buildLoading();
        } else {
          return buildInitialScreen(context);
        }
      },
    );
  }

  Widget buildInitialScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.orange,
                    onSurface: Colors.grey,
                    minimumSize: const Size(250, 60),
                  ),
                  onPressed: () {
                    BlocProvider.of<WelcomeScreenCubit>(context)
                        .navigateToSignInScreenEvent();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Se connecter",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Bienvenue !",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 1200,
              child: Expanded(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
