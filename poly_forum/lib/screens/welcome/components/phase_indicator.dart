import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhaseIndicator extends StatefulWidget {
  final User user;
  const PhaseIndicator({required this.user, Key? key}) : super(key: key);

  @override
  State<PhaseIndicator> createState() => _PhaseIndicatorState();
}

class _PhaseIndicatorState extends State<PhaseIndicator> {
  late Phase currentPhase;
  HashMap<int, List<Info>> infos = HashMap<int, List<Info>>();

  @override
  void initState() {
    super.initState();

    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();

    if (widget.user is CandidateUser) {
      BlocProvider.of<InfoPhaseCubit>(context)
          .initInfoPhaseCandidat(widget.user as CandidateUser, currentPhase);
    } else if (widget.user is CompanyUser) {
      BlocProvider.of<InfoPhaseCubit>(context)
          .initInfoPhaseCompany(widget.user as CompanyUser, currentPhase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoPhaseCubit, InfoPhaseState>(
      listener: (context, state) {
        if (state is InfoPhaseLoaded) {
          infos = state.infos;
        }
      },
      builder: (context, state) {
        if (state is InfoPhaseLoaded) {
          infos = state.infos;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  buildItem(
                    context,
                    "1",
                    "Inscription",
                    currentPhase == Phase.inscription,
                    const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  if (infos.containsKey(0))
                    for (var info in infos[0]!)
                      buildInfoNotification(context, info),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                children: [
                  buildItem(
                    context,
                    "2",
                    "Vœux",
                    currentPhase == Phase.wish,
                    const BorderRadius.all(Radius.zero),
                  ),
                  if (infos.containsKey(1))
                    for (var info in infos[1]!)
                      buildInfoNotification(context, info),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                children: [
                  buildItem(
                    context,
                    "3",
                    "Planning",
                    currentPhase == Phase.planning,
                    const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  if (infos.containsKey(2))
                    for (var info in infos[2]!)
                      buildInfoNotification(context, info),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildItem(BuildContext context, String nb, String text, bool active,
      BorderRadius borderRadius) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 80,
      decoration: BoxDecoration(
        color: active ? kPrimaryColor : Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: kButtonColor,
            radius: 20,
            child: Text(
              nb,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget buildInfoNotification(BuildContext context, Info info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30),
          info.isValid
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
          const SizedBox(width: 10),
          Text(
            info.text,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
