import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';

class SlotPlanning extends StatelessWidget {
  const SlotPlanning({Key? key, required this.slot}) : super(key: key);

  final Slot slot;

  // Widget buildEmptySlot() {
  //   return SizedBox(
  //     height: 90,
  //     child: Row(
  //       children: <Widget>[
  //         SizedBox(
  //           width: 100,
  //           child: Text(
  //             slot.period,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(fontSize: 15),
  //           ),
  //         ),
  //         const VerticalDivider(
  //           color: Colors.black45,
  //           width: 1.5,
  //         ),
  //         Expanded(
  //           child: Container(
  //             color: Colors.black12,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget buildMeetingSlot() {
    return SizedBox(
        height: 50,
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
          // const Padding(
          //     padding: EdgeInsets.only(left: 10, right: 30, bottom: 3, top: 3),
          //     child: CircleAvatar(
          //       radius: 30,
          //       backgroundImage: AssetImage('images/clyde.png'),
          //     )),
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
    // if (slot.companyName == null) {
    //   return buildEmptySlot();
    // } else {
    return buildMeetingSlot();
    // }
  }
}
