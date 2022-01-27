import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'home_planning_card.dart';

class HomePlanningScreen extends StatelessWidget {
  final VoidCallback onCompanyPlanningPressed;
  final VoidCallback onCandidatePlanningPressed;

  const HomePlanningScreen({
    Key? key,
    required this.onCandidatePlanningPressed,
    required this.onCompanyPlanningPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //     "Accès aux plannings",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 40,
            //     )
            // ),
            const SizedBox(height: 15),
            HomePlanningCard(
              title: "Planning des entreprises",
              iconData: Icons.calendar_today_outlined,
              onPressed: onCompanyPlanningPressed,
            ),
            HomePlanningCard(
              title: "Planning des candidats",
              iconData: Icons.calendar_today_outlined,
              onPressed: onCandidatePlanningPressed,
            ),
          ],
        ),
      ),
    );
  }
}
