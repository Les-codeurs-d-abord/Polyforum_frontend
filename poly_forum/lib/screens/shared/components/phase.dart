import 'package:extension/extension.dart';

class Phase extends Enum<String> {

  const Phase(String value) : super(value);

  static const Phase inscription = Phase("INSCRIPTION");
  static const Phase wish = Phase("VOEUX");
  static const Phase planning = Phase("PLANNING");

  static Phase fromJson(Map<String, dynamic> json) {
    if (inscription == json['currentPhase']) {
      return inscription;
    } else if (wish == json['currentPhase']) {
      return wish;
    } else if (planning == json['currentPhase']) {
      return planning;
    } else {
      throw Exception("Phase inconnue");
    }
  }

  @override
  bool operator ==(dynamic other) =>
      other is Enum && other.value == value ||
          other is String && other == value;

  @override
  int get hashCode => super.hashCode;
}
