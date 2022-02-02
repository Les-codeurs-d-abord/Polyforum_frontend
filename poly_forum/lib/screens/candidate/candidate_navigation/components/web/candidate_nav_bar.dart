import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/shared/components/nav_bar_profil_btn.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/welcome/components/info_phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandidateNavBar extends StatelessWidget {
  final CandidateUser user;
  final Function onProfileSelected;
  final List<Widget> paths;
  final String title;

  const CandidateNavBar(
      {required this.user,
      required this.onProfileSelected,
      required this.paths,
      required this.title,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPhase = BlocProvider.of<PhaseCubit>(context).currentPhase;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      height: 70,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 0; i < paths.length; i++)
                    Row(
                      children: [
                        paths[i],
                        i < paths.length - 1
                            ? const Icon(Icons.arrow_right)
                            : const SizedBox.shrink(),
                      ],
                    ),
                ],
              ),
              const Spacer(),
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
                    if (currentPhase == Phase.wish &&
                        state.infos.containsKey(1)) {
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
                                BlocProvider.of<CandidateNavigationCubit>(
                                        context)
                                    .setSelectedItem(5);
                              } else if (value == 1) {
                                BlocProvider.of<CandidateNavigationCubit>(
                                        context)
                                    .setSelectedItem(1);
                              }
                            },
                            itemBuilder: (context) => [
                              if (currentPhase == Phase.inscription &&
                                  state.infos.containsKey(0))
                                for (var info in state.infos[0]!)
                                  PopupMenuItem(
                                    value: 0,
                                    child:
                                        InfoPhase(context: context, info: info),
                                  ),
                              if (currentPhase == Phase.wish &&
                                  state.infos.containsKey(1))
                                for (var info in state.infos[1]!)
                                  PopupMenuItem(
                                    value: 1,
                                    child:
                                        InfoPhase(context: context, info: info),
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
                                      color: Colors.red, size: 25))
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
                uri: user.logo,
                text: user.firstName + " " + user.lastName,
                textTypeUser: "Candidat",
                onProfileSelected: onProfileSelected,
              ),
            ],
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: kButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
