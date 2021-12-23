import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 250,
      child: Card(
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      "images/inetum_logo.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Consultant technique SAP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Inetum",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_outlined),
                ],
              ),
              const SizedBox(height: 15),
              const SizedBox(
                height: 110,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 7,
                  style: TextStyle(),
                ),
              ),
              const Spacer(),
              Container(
                height: 30,
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    Tags(text: "Flutter"),
                    Tags(text: "C++"),
                    Tags(text: "Angular"),
                    Tags(text: "C#"),
                    Tags(text: "Angular"),
                    Tags(text: "Angular"),
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
