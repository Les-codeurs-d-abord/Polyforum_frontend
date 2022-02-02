import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/offers/offers_screen.dart';
import 'package:poly_forum/screens/candidate/planning/planning_screen.dart';
import 'package:poly_forum/screens/candidate/profil/edit/candidate_profil_screen.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_screen.dart';
import 'package:poly_forum/screens/candidate/wishlist/choices_screen.dart';
import 'package:poly_forum/screens/password/change_password_screen.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/welcome/components/info_phase.dart';
import 'package:poly_forum/screens/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/nav_bar_profil_btn.dart';
import '../tab_navigation_item_list.dart';

class CandidatePhoneBody extends StatelessWidget {
  const CandidatePhoneBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateNavigationCubit, CandidateNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is CandidateNavigationLoaded) {
          return buildScreen(
            context,
            state.index,
            BlocProvider.of<CandidateGetUserCubit>(context).getUser(),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildScreen(
      BuildContext context, int selectedIndex, CandidateUser candidateUser) {
    final currentPhase = BlocProvider.of<PhaseCubit>(context).currentPhase;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          primary: false,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset('images/logo.png'),
              ),
            ),
            TabNavigationItemList(selectedIndex: selectedIndex),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          getTitle(selectedIndex),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          BlocConsumer<InfoPhaseCubit, InfoPhaseState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is InfoPhaseLoaded) {
                bool notif = false;
                if (currentPhase == Phase.inscription &&
                    state.infos.containsKey(0)) {
                  for (var info in state.infos[0]!) {
                    if (!info.isValid) notif = true;
                  }
                }
                if (currentPhase == Phase.wish && state.infos.containsKey(1)) {
                  for (var info in state.infos[1]!) {
                    if (!info.isValid) notif = true;
                  }
                }

                return Center(
                  child: Stack(
                    children: [
                      PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 0) {
                            BlocProvider.of<CandidateNavigationCubit>(context)
                                .setSelectedItem(5);
                          } else if (value == 1) {
                            BlocProvider.of<CandidateNavigationCubit>(context)
                                .setSelectedItem(1);
                          }
                        },
                        itemBuilder: (context) => [
                          if (currentPhase == Phase.inscription &&
                              state.infos.containsKey(0))
                            for (var info in state.infos[0]!)
                              PopupMenuItem(
                                value: 0,
                                child: InfoPhase(context: context, info: info),
                              ),
                          if (currentPhase == Phase.wish &&
                              state.infos.containsKey(1))
                            for (var info in state.infos[1]!)
                              PopupMenuItem(
                                value: 1,
                                child: InfoPhase(context: context, info: info),
                              ),
                        ],
                        tooltip: "Notifications",
                        child: const Icon(
                          Icons.notifications,
                          size: 40,
                        ),
                      ),
                      notif
                          ? const IgnorePointer(
                              child: Icon(Icons.circle,
                                  color: Colors.red, size: 15))
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              } else if (state is InfoPhaseError) {
                return const SizedBox.shrink();
              }

              return const CircularProgressIndicator();
            },
          ),
          NavBarProfilBtn(
            uri: candidateUser.logo,
            text: candidateUser.firstName + " " + candidateUser.lastName,
            textTypeUser: "Candidat",
            onProfileSelected: () {
              BlocProvider.of<CandidateNavigationCubit>(context)
                  .setSelectedItem(4);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: <Widget>[
                WelcomeScreen(
                    user: BlocProvider.of<CandidateGetUserCubit>(context).user),
                OffersScreen(user: candidateUser),
                ChoicesScreen(user: candidateUser),
                PlanningScreen(user: candidateUser),
                HomeProfileScreen(
                  onEditProfilePressed: () {
                    BlocProvider.of<CandidateNavigationCubit>(context)
                        .setSelectedItem(5);
                  },
                  onChangePasswordPressed: () {
                    BlocProvider.of<CandidateNavigationCubit>(context)
                        .setSelectedItem(6);
                  },
                ),
                CandidateProfilScreen(candidateUser: candidateUser),
                ChangePasswordScreen(
                    BlocProvider.of<CandidateGetUserCubit>(context).getUser()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(int selectedIndex) {
    String title = "";

    switch (selectedIndex) {
      case 0:
        title = "Le forum";
        break;
      case 1:
        title = "Les offres proposées";
        break;
      case 2:
        title = "Organisation des voeux";
        break;
      case 3:
        title = "Mon planning";
        break;
      case 4:
        title = "Mon profil";
        break;
      case 5:
        title = "Modifier mon profil";
        break;
      case 6:
        title = "Changer le mot de passe";
        break;
    }

    return title;
  }
}
