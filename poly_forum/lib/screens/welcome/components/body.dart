import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/constants.dart';
import 'package:poly_forum/cubit/welcome_screen_cubit.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: //Padding(
          //padding: const EdgeInsets.all(50),
          /*child:*/ Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const SizedBox(),
            SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Polytech",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 100),
                      Text(
                        "Polytech Lyon est l’école d’ingénieur interne de l’Université Claude Bernard Lyon1.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 26),
                      ),
                      const SizedBox(height: 100),
                      MaterialButton(
                        onPressed: _launchURL,
                        color: Colors.orange,
                        child: Text(
                          "En savoir plus",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Container(
                color: kSecondaryColor,
                child: Center(
                  child: Image.asset(
                    "images/welcome/class.png",
                    width: 800,
                    height: 600,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]),
          Row(children: [
            Expanded(
              child: Container(
                color: kSecondaryColor,
                child: Center(
                  child: Image.asset(
                    "images/welcome/alternance.png",
                    width: 800,
                    height: 600,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(),
            SizedBox(
                width: 600,
                child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "L'alternance",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(height: 100),
                        Text(
                          "Elle dispense une formation d’ingénieur informatique par alternance.  <ajouter phrase sur comment c’est bien pour l’élève et l’entreprise>",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 26),
                        ),
                      ],
                    )))
          ]),
          Row(children: [
            const SizedBox(),
            SizedBox(
                width: 600,
                child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Le forum",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(height: 100),
                        Text(
                          "Ce forum vous permettra de rentrer en contact avec vos futur.e.s alternant.e.s / entreprises !",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: 100),
                        MaterialButton(
                          onPressed: () {
                            BlocProvider.of<WelcomeScreenCubit>(context)
                                .navigateToSignInScreenEvent();
                          },
                          color: Colors.orange,
                          child: Text(
                            "Se connecter",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ))),
            Expanded(
              child: Container(
                color: kSecondaryColor,
                child: Center(
                  child: Image.asset(
                    "images/welcome/forum.png",
                    width: 800,
                    height: 600,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
      //),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _launchURL() async {
    const url = 'https://polytech.univ-lyon1.fr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
