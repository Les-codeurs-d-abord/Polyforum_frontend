class Slot {
  final String period;
  final int? userCompany;
  final String? companyName;
  final String? logo;

  const Slot(
      {this.companyName, this.logo, this.userCompany, required this.period});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
        companyName: json['companyName'],
        logo: json['logo'],
        userCompany: json['userMet'],
        period: json['period']);
  }
}
