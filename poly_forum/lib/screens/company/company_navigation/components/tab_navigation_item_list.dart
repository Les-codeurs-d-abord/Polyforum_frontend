import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
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
              "PolyForum",
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
            BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(0);
          },
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 1,
          selectedIndex: selectedIndex,
          text: "Mes offres",
          iconSelected: Icons.local_offer,
          iconNonSelected: Icons.local_offer_outlined,
          onPressed: () {
            BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(1);
          },
          children: [
            if (BlocProvider.of<PhaseCubit>(context).getCurrentPhase() == Phase.inscription)
              TabChildNavigationItem(
                index: 2,
                selectedIndex: selectedIndex,
                text: "Créer une offre",
                onPressed: () {
                  BlocProvider.of<CompanyNavigationCubit>(context)
                      .setSelectedItem(2);
                },
              ),
            if (BlocProvider.of<PhaseCubit>(context).getCurrentPhase() == Phase.inscription)
              TabChildNavigationItem(
                index: 9,
                selectedIndex: selectedIndex,
                text: "Modifier une offre",
                onPressed: selectedIndex == 9
                    ? () {
                  BlocProvider.of<CompanyNavigationCubit>(context)
                      .setSelectedItem(9);
                }
                    : null,
              ),
          ],
        ),
        const SizedBox(height: 20),
        if (BlocProvider.of<PhaseCubit>(context).getCurrentPhase() != Phase.inscription)
          Column(
            children: [
              TabNavigationItem(
                index: 3,
                selectedIndex: selectedIndex,
                text: "Les candidats",
                iconSelected: Icons.school,
                iconNonSelected: Icons.school_outlined,
                onPressed: () {
                  BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(3);
                },
              ),
              const SizedBox(height: 20),
              TabNavigationItem(
                index: 4,
                selectedIndex: selectedIndex,
                text: "Mes voeux",
                iconSelected: Icons.bookmark_outlined,
                iconNonSelected: Icons.bookmark_border,
                onPressed: () {
                  BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(4);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        if (BlocProvider.of<PhaseCubit>(context).getCurrentPhase() == Phase.planning)
          Column(
            children: [TabNavigationItem(
              index: 5,
              selectedIndex: selectedIndex,
              text: "Mon planning",
              iconSelected: Icons.today,
              iconNonSelected: Icons.today_outlined,
              onPressed: () {
                BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(5);
              },
            ),
              const SizedBox(height: 20),
            ],
          ),
        TabNavigationItem(
          index: 6,
          selectedIndex: selectedIndex,
          text: "Mon profil",
          iconSelected: Icons.person,
          iconNonSelected: Icons.person_outline,
          onPressed: () {
            BlocProvider.of<CompanyNavigationCubit>(context).setSelectedItem(6);
          },
          children: [
            TabChildNavigationItem(
              index: 7,
              selectedIndex: selectedIndex,
              text: "Modifier mon profil",
              onPressed: () {
                BlocProvider.of<CompanyNavigationCubit>(context)
                    .setSelectedItem(7);
              },
            ),
            TabChildNavigationItem(
              index: 8,
              selectedIndex: selectedIndex,
              text: "Changer mon mot de passe",
              onPressed: () {
                BlocProvider.of<CompanyNavigationCubit>(context)
                    .setSelectedItem(8);
              },
            ),
          ],
        ),
      ],
    );
  }
}
