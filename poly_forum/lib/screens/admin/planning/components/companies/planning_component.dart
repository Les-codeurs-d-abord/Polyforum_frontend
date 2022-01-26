import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/screens/admin/planning/components/companies/slot_component.dart';

class PlanningWidget extends StatelessWidget {
  final Planning planning;

  const PlanningWidget({Key? key, required this.planning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 7),
            itemCount: planning.slots.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: 1,
                ),
            itemBuilder: (BuildContext context, int index) {
              return SlotPlanning(
                slot: planning.slots[index],
              );
            }));
  }
}
