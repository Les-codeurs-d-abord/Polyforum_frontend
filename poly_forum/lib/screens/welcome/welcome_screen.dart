import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:poly_forum/screens/welcome/components/localization_info.dart';
import 'package:poly_forum/screens/welcome/components/phase_indicator.dart';
import 'package:poly_forum/screens/welcome/components/presentation_card.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      width: double.infinity,
      childPadding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Déroulement du forum d'entreprise",
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Cette application a pour objectif l’organisation des rencontres entre les futurs apprentis de Polytech et des entreprises prêtes à recruter. Afin que ces rencontres soient efficaces, les entreprises pourront, grâce à l'application, décider quels candidats les intéressent et les candidats pourront en faire de même avec les entreprises. À la suite de cela, un planning sera généré et permettra aux candidats et entreprises de savoir où et quand la rencontre va se faire !",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 40),
                Text(
                  "Ce forum va se dérouler en plusieurs étapes :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: kButtonColor,
                      radius: 20,
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Etape d’inscription : les candidats et entreprises renseignent les informations demandées",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: kButtonColor,
                      radius: 20,
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Etape de renseignement des vœux : les candidats et entreprises ne pourront plus changer les informations personnelles entrées et pourront renseigner leurs vœux",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: kButtonColor,
                      radius: 20,
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Etape de planning : les candidats et entreprises ne pourront plus changer leurs vœux et auront accès à leur planning des rencontres de la journée du forum",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "Etape actuelle",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 10),
                const PhaseIndicator(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Center(
                  child: Text(
                    "Informations utiles",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: const [
                          PresentationCard(
                            img: "images/p.png",
                            title: "Polytech Lyon",
                            text:
                                "Polytech Lyon fait partie du réseau Polytech ; elle est l’école d’ingénieur interne de l’Université Claude Bernard Lyon 1. Elle propose différentes formations réparties en 6 départements, dont le département Informatique. La formation d’ingénieur informatique est réalisable en cursus initial et en cursus par apprentissage",
                            link:
                                "https://polytech.univ-lyon1.fr/ecole/presentation",
                          ),
                          PresentationCard(
                            img: "images/a.png",
                            title: "L'alternance",
                            text:
                                "Polytech propose un cursus de formation d’ingénieur informatique dispensable en alternance. L’alternance va apporter beaucoup aux parties impliquées. L’apprenti.e va pouvoir gagner des connaissances théoriques, tout en se formant à la vie d’entreprise. L’entreprise aura de son côté la possibilité de former de jeunes apprentis selon leurs besoins."
                                "\nL’alternance est le pont parfait entre la vie étudiante et la vie professionnelle !",
                            link:
                                "https://www.alternance.emploi.gouv.fr/decouvrir-lalternance",
                          ),
                          PresentationCard(
                            img: "images/v.png",
                            title: "La vie étudiante",
                            text:
                                "Être étudiant.e à l'université Claude Bernard Lyon1, c'est avoir accès au nécessaire pour réussir ses études. Des restaurants universitaires multiples, des logements proches du campus, des bibliothèques dans lesquelles vous pourrez travailler en toute tranquilité... Le campus de la Doua saura vous accueillir !",
                            link:
                                "https://polytech.univ-lyon1.fr/vie-etudiante/vie-pratique",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const LocalizationInfo(),
        ],
      ),
    );
  }
}
