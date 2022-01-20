import 'package:poly_forum/data/models/slot_model.dart';

class Planning {
  final List<Slot> slots;

  const Planning({required this.slots});

  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(slots: json['slot']);
  }
}
