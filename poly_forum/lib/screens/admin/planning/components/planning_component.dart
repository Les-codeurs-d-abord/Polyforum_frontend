import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/screens/admin/planning/components/slot_component.dart';

class PlanningWidget extends StatelessWidget {
  final Planning planning;

  const PlanningWidget({Key? key, required this.planning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return
    // Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    // children: [
    // Padding(
    //     padding: const EdgeInsets.only(left: 30, top: 20),
    //     child: Text(
    //       "Planning du 5 mars 2022",
    //       style: Theme.of(context).textTheme.headline3,
    //     )),
    return Expanded(
        // alignment: Alignment.center,
        child: ListView.separated(
            padding: const EdgeInsets.only(
                right: 200, left: 200, top: 10, bottom: 0),
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

    // ],
    // );
  }
}
