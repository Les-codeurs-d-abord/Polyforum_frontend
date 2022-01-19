class Slot {
  final String period;
  final int? userCompany;
  final String? companyName;
  final String? candidateName;
  final String? logo;

  const Slot(
      {this.companyName,
      this.logo,
      this.userCompany,
      this.candidateName,
      required this.period});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
        companyName: json['companyName'],
        logo: json['logo'],
        userCompany: json['userMet'],
        candidateName: json['candidateName'],
        period: json['period']);
  }
}
