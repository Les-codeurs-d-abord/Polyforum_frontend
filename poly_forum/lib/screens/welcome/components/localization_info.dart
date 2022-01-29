import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalizationInfo extends StatelessWidget {
  const LocalizationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Localisation",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: const Text(
              "15 Bd André Latarjet, 69100 VILLEURBANNE",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => launch(
                "https://www.google.fr/maps/place/15+Bd+Andr%C3%A9+Latarjet,+69100+Villeurbanne/@45.7792134,4.8661922,16z/data=!4m5!3m4!1s0x47f4ea98fe122a47:0x32c97ce90d0cf86!8m2!3d45.7792637!4d4.868203?hl=fr"),
          ),
        ),
        Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
