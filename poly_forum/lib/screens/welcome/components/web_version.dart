import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WebVersion extends StatelessWidget {
  const WebVersion({Key? key}) : super(key: key);

  get kSecondaryColor => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Polytech",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "Polytech Lyon est l’école d’ingénieur interne de l’Université Claude Bernard Lyon1.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 26),
                      ),
                      const SizedBox(height: 50),
                      TextButton(
                        onPressed: () {
                          launch("https://polytech.univ-lyon1.fr/");
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: kButtonColor),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "En savoir plus",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    "images/class.jpg",
                    height: 300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset("images/alternance.jpg", height: 250),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "L'alternance",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 50),
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
              ],
            ),
            const SizedBox(height: 0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Le forum",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "Ce forum vous permettra de rentrer en contact avec vos futur.e.s alternant.e.s / entreprises !",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 26),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset("images/forum.jpg", width: 300),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nous trouver",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    child: const Text(
                      "15 Bd André Latarjet, 69100 VILLEURBANNE",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launch(
                        "https://www.google.fr/maps/place/15+Bd+Andr%C3%A9+Latarjet,+69100+Villeurbanne/@45.7792134,4.8661922,16z/data=!4m5!3m4!1s0x47f4ea98fe122a47:0x32c97ce90d0cf86!8m2!3d45.7792637!4d4.868203?hl=fr"),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('images/maps.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
