class CompanyMinimal {
  final int userId;
  final String companyName;

  CompanyMinimal({required this.userId, required this.companyName});

  factory CompanyMinimal.fromJson(Map<String, dynamic> json) {
    return CompanyMinimal(
        userId: json['userId'], companyName: json['companyName']);
  }
}
