import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PresentationCard extends StatelessWidget {
  final String img;
  final String title;
  final String text;
  final String link;

  const PresentationCard(
      {required this.img,
      required this.title,
      required this.text,
      required this.link,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          launch(link);
        },
        child: Container(
          width: 400,
          height: 400,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
