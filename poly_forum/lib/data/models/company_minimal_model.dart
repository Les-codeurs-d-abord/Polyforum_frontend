class CompanyMinimal {
  final int userId;
  final String companyName;
  final String? logo;

  CompanyMinimal({required this.userId, required this.companyName, this.logo});

  factory CompanyMinimal.fromJson(Map<String, dynamic> json) {
    return CompanyMinimal(
      userId: json['userId'],
      companyName: json['companyName'],
      logo: json['logo'],
    );
  }

  factory CompanyMinimal.fromJsonWithUserId(Map<String, dynamic> json) {
    return CompanyMinimal(
      userId: json['user']['id'],
      companyName: json['companyName'],
      logo: json['logo'],
    );
  }
}
