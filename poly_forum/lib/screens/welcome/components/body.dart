import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/constants.dart';
import 'package:poly_forum/cubit/welcome_screen_cubit.dart';
import 'package:poly_forum/screens/home/home_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:footer/footer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1080) {
        return SingleChildScrollView(
          child: Column(
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
                            onPressed: _launchURLPolytech,
                            color: Colors.orange,
                            height: 50,
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
                              "Elle dispense une formation d’ingénieur informatique par alternance. L'alternance offre aux entreprises l'occasion de former de futur.e.s employé.e.s, et aux élèves de suivre leur formation dans un cadre professionnel.",
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
                              height: 50,
                              child: Text(
                                "Se connecter",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
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
                ),
              ]),
              Footer(
                child: Row(children: [
                  const SizedBox(),
                  SizedBox(
                      width: 600,
                      child: (Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text:
                                        "15 Bd André Latarjet, 69100 VILLEURBANNE",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchURLMaps();
                                      })),
                            Text("04 26 23 71 42")
                          ],
                        ),
                      ))),
                  Expanded(
                      child: Image.asset(
                    'images/polytech_map.PNG',
                    height: 300,
                    fit: BoxFit.cover,
                  )),
                ]),
              )
            ],
          ),
          //),
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          onPressed: _launchURLPolytech,
                          color: Colors.orange,
                          height: 50,
                          child: Text(
                            "En savoir plus",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
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
                            "Elle dispense une formation d’ingénieur informatique par alternance. L'alternance offre aux entreprises l'occasion de former de futur.e.s employé.e.s, et aux élèves de suivre leur formation dans un cadre professionnel.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 26),
                          ),
                        ],
                      ))),
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
                            height: 50,
                            child: Text(
                              "Se connecter",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ))),
              Footer(
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "15 Bd André Latarjet, 69100 VILLEURBANNE",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchURLMaps();
                              })),
                    Text("04 26 23 71 42")
                  ],
                ),
              )
            ],
          ),
        );
      }
    });
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _launchURLPolytech() async {
    const url = 'https://polytech.univ-lyon1.fr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMaps() async {
    const url =
        'https://www.google.fr/maps/place/15+Bd+Andr%C3%A9+Latarjet,+69100+Villeurbanne/@45.7792134,4.8661922,16z/data=!4m5!3m4!1s0x47f4ea98fe122a47:0x32c97ce90d0cf86!8m2!3d45.7792637!4d4.868203?hl=fr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
