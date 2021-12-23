import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/offer_details/components/body.dart';
import 'package:poly_forum/utils/constants.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset(
                "images/inetum_logo.png",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 20),
            const Text(
              "Inetum",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              " - ",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: const Text(
                "Consultant Technique SAP",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: kButtonColor,
                onSurface: Colors.grey,
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text("Continuer pour postuler"),
              ),
            ),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
