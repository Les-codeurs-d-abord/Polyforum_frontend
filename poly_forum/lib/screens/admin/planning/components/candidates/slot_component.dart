import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/planning/candidates/admin_fill_slot_modal_candidate_cubit.dart';
import 'package:poly_forum/cubit/admin/planning/candidates/admin_planning_candidates_screen_cubit.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';

import 'fill_slot_modal.dart';

class SlotPlanning extends StatelessWidget {
  const SlotPlanning({Key? key, required this.slot}) : super(key: key);

  final Slot slot;

  Widget buildEmptySlot(context) {
    return InkWell(
        child: SizedBox(
          height: 55,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  slot.period,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const VerticalDivider(
                color: Colors.black45,
                width: 1.5,
              ),
              Expanded(
                child: Container(
                  color: Colors.black12,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          modal_fill_slot(context, slot.userPlanning, slot.period);
        });
  }

  void modal_fill_slot(context, userId, period) {
    showDialog(
            context: context,
            builder: (BuildContext context) {
              return BlocProvider(
                  create: (context) => AdminFillSlotModalCubit(),
                  child: FillSlotModal(userId: userId, period: period));
            },
            barrierDismissible: false)
        .then((value) {
      if (value == ModalSlotReturn.confirm) {
        BlocProvider.of<AdminPlanningCandidatesCubit>(context)
            .fetchPlanningForGivenCandidate(userId);
      }
    });
  }

  Widget buildMeetingSlot(context) {
    return SizedBox(
        height: 55,
        child: Row(children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              slot.period,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const VerticalDivider(
            color: Colors.black45,
            width: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: ProfilePicture(
                uri: slot.logo ?? '',
                name: slot.companyName ?? '?',
              ),
            ),
          ),
          Expanded(
            child: Text(
              slot.companyName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          deleteIcon(context, slot.companyName, slot.candidateName),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    if (slot.companyName == null) {
      return buildEmptySlot(context);
    } else {
      return buildMeetingSlot(context);
    }
  }

  Widget deleteIcon(context, companyName, candidateName) {
    return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationModal(
                      title: "Supprimer un rendez-vous",
                      description:
                          "Voulez-vous supprimer le rendez-vous initialement prévu entre le/la candidat.e $candidateName et l'entreprise $companyName ?",
                    );
                  },
                  barrierDismissible: false)
              .then((value) {
            if (value == ModalReturn.confirm) {
              BlocProvider.of<AdminPlanningCandidatesCubit>(context)
                  .removeMeeting(slot.userPlanning, slot.userMet, slot.period);
            }
          });
        });
  }
}
