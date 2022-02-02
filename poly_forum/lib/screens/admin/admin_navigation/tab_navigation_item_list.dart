import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_navigation_cubit.dart';
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
    final currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
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
            BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(0);
          },
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 1,
          selectedIndex: selectedIndex,
          text: "Tableau de bord",
          iconSelected: Icons.space_dashboard,
          iconNonSelected: Icons.space_dashboard_outlined,
          onPressed: () {
            BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(1);
          },
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 2,
          selectedIndex: selectedIndex,
          text: "Entreprises",
          iconSelected: Icons.business,
          iconNonSelected: Icons.business_outlined,
          onPressed: () {
            BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(2);
          },
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 3,
          selectedIndex: selectedIndex,
          text: "Candidats",
          iconSelected: Icons.school,
          iconNonSelected: Icons.school_outlined,
          onPressed: () {
            BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(3);
          },
        ),
        const SizedBox(height: 20),
        TabNavigationItem(
          index: 4,
          selectedIndex: selectedIndex,
          text: "Planning",
          iconSelected: Icons.today,
          iconNonSelected: Icons.today_outlined,
          isEnable: currentPhase == Phase.planning,
          messageToolTipOnLock:
              "Cet onglet sera disponible durant la troisième phase : Génération du planning",
          onPressed: () {
            BlocProvider.of<AdminNavigationCubit>(context).setSelectedItem(4);
          },
          children: [
            TabChildNavigationItem(
              index: 5,
              selectedIndex: selectedIndex,
              text: "Entreprises",
              onPressed: () {
                BlocProvider.of<AdminNavigationCubit>(context)
                    .setSelectedItem(5);
              },
            ),
            TabChildNavigationItem(
              index: 6,
              selectedIndex: selectedIndex,
              text: "Candidats",
              onPressed: () {
                BlocProvider.of<AdminNavigationCubit>(context)
                    .setSelectedItem(6);
              },
            ),
          ],
        ),
      ],
    );
  }
}
