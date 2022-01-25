import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/admin_planning_candidates_screen_cubit.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'package:poly_forum/screens/admin/planning/components/pop_up_fill_slot.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modal_screen.dart';

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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FillSlotModalScreen(
                  period: slot.period,
                );
              });
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
          Container(
              padding: const EdgeInsets.all(8),
              width: 70,
              child: slot.logo != null
                  ? const Text('y a une pp')
                  : InitialsAvatar(slot.companyName ?? 'Unknown')),
          Expanded(
            child: Text(
              slot.companyName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
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
}
