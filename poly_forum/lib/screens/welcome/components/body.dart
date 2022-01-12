import 'package:flutter/material.dart';
import 'package:poly_forum/screens/welcome/components/web_version.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildInitialScreen(context);
  }

  Widget buildInitialScreen(BuildContext context) {
    return const WebVersion();
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1080) {
        return const WebVersion();
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
                ),
              ),
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
                  ),
                ),
              ),
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
                        onPressed: () {},
                        color: Colors.orange,
                        height: 50,
                        child: Text(
                          "Se connecter",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Footer(
              //   child: Column(
              //     children: [
              //       RichText(
              //           text: TextSpan(
              //               text: "15 Bd André Latarjet, 69100 VILLEURBANNE",
              //               recognizer: TapGestureRecognizer()
              //                 ..onTap = () {
              //                   _launchURLMaps();
              //                 })),
              //       Text("04 26 23 71 42")
              //     ],
              //   ),
              // )
            ],
          ),
        );
      }
    });
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
