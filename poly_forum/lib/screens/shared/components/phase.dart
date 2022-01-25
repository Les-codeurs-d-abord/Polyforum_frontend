import 'package:extension/extension.dart';

class Phase extends Enum<String> {

  const Phase(String value) : super(value);

  static const Phase inscription = Phase("INSCRIPTION");
  static const Phase wish = Phase("VOEUX");
  static const Phase planning = Phase("PLANNING");

  @override
  bool operator ==(dynamic other) =>
      other is Enum && other.value == value ||
          other is String && other == value;

  @override
  int get hashCode => super.hashCode;
}
