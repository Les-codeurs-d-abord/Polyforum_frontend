import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_child_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/navigation/tab_navigation_item.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';

class TabNavigationItemList extends StatelessWidget {
  final int selectedIndex;

  const TabNavigationItemList({required this.selectedIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Phase currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'images/logo.png',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              "Poly Forum",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        TabNavigationItem(
          index: 0,
          selectedIndex: selectedIndex,
          text: "Le forum",
          iconSelected: Icons.home,
          iconNonSelected: Icons.home_outlined,
          onPressed: () {
            BlocProvider.of<CandidateNavigationCubit>(context)
                .setSelectedItem(0);
          },
        ),
        const SizedBox(height: 20),
        Column(children: [
          TabNavigationItem(
            index: 1,
            selectedIndex: selectedIndex,
            text: "Les offres",
            iconSelected: Icons.local_offer,
            iconNonSelected: Icons.local_offer_outlined,
            isEnable: currentPhase == Phase.wish,
            messageToolTipOnLock:
                "Cet onglet sera disponible durant la deuxième phase : Saisie des voeux",
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(1);
            },
          ),
          const SizedBox(height: 20),
          TabNavigationItem(
            index: 2,
            selectedIndex: selectedIndex,
            text: "Mes voeux",
            iconSelected: Icons.bookmark_outlined,
            iconNonSelected: Icons.bookmark_border,
            isEnable: currentPhase == Phase.wish,
            messageToolTipOnLock:
                "Cet onglet sera disponible durant la deuxième phase : Saisie des voeux",
            onPressed: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(2);
            },
          ),
          const SizedBox(height: 20),
        ]),
        Column(
          children: [
            TabNavigationItem(
              index: 3,
              selectedIndex: selectedIndex,
              text: "Mon planning",
              iconSelected: Icons.today,
              iconNonSelected: Icons.today_outlined,
              isEnable: currentPhase == Phase.planning,
              messageToolTipOnLock:
                  "Cet onglet sera disponible durant la troisième phase : Génération du planning",
              onPressed: () {
                BlocProvider.of<CandidateNavigationCubit>(context)
                    .setSelectedItem(3);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
        TabNavigationItem(
          index: 4,
          selectedIndex: selectedIndex,
          text: "Mon profil",
          iconSelected: Icons.person,
          iconNonSelected: Icons.person_outline,
          onPressed: () {
            BlocProvider.of<CandidateNavigationCubit>(context)
                .setSelectedItem(4);
          },
          children: [
            TabChildNavigationItem(
              index: 5,
              selectedIndex: selectedIndex,
              text: "Modifier mon profil",
              onPressed: () {
                BlocProvider.of<CandidateNavigationCubit>(context)
                    .setSelectedItem(5);
              },
            ),
            TabChildNavigationItem(
              index: 6,
              selectedIndex: selectedIndex,
              text: "Changer mon mot de passe",
              onPressed: () {
                BlocProvider.of<CandidateNavigationCubit>(context)
                    .setSelectedItem(6);
              },
            ),
          ],
        ),
      ],
    );
  }
}
