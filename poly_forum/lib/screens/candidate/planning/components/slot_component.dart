import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';

class SlotPlanning extends StatelessWidget {
  const SlotPlanning({Key? key, required this.slot}) : super(key: key);

  final Slot slot;

  Widget buildEmptySlot() {
    return SizedBox(
      height: 50,
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
    );
  }

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
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ProfilePicture(
              uri: slot.logo ?? '',
              defaultText: slot.companyName ?? '?',
              width: 70,
              height: 70,
            ),
          ),
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
      return buildEmptySlot();
    } else {
      return buildMeetingSlot();
    }
  }
}
