class Slot {
  final int id;
  final String period;
  final int? userMet;
  final int? userPlanning;
  final String? companyName;
  final String? candidateName;
  final String? logo;

  const Slot(
      {required this.id,
      this.companyName,
      this.logo,
      this.userMet,
      this.userPlanning,
      this.candidateName,
      required this.period});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
        id: json['id'],
        companyName: json['companyName'],
        logo: json['logo'],
        userMet: json['userMet'],
        userPlanning: json['userPlanning'],
        candidateName: json['candidateName'],
        period: json['period']);
  }

  static Map<String, dynamic> meetingRequest(
          userIdCandidate, userIdCompany, period) =>
      {
        "userIdCandidate": userIdCandidate,
        "userIdCompany": userIdCompany,
        "period": period
      };
}
