class CompanyDetail {
  final int id;
  final String companyName;
  final String? phoneNumber;
  final String? description;
  final String? logo;
  final String email;
  final List<String> links;
  final int userId;

  CompanyDetail({
    required this.id,
    required this.companyName,
    required this.phoneNumber,
    required this.description,
    required this.logo,
    required this.email,
    required this.links,
    required this.userId,
  });

  factory CompanyDetail.fromJson(Map<String, dynamic> json) {
    List<String> links = [];

    for (Map<String, dynamic> link in json['company_links'] ?? []) {
      links.add(link['label']);
    }

    return CompanyDetail(
      id: json['id'],
      companyName: json['companyName'],
      phoneNumber: json['phoneNumber'],
      description: json['description'],
      logo: json['logo'],
      email: json['user']['email'],
      links: links,
      userId: json['user']['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "phoneNumber": phoneNumber,
    "description": description,
    "logo": logo,
    "email": email,
    "userId": userId,
  };

  @override
  String toString() {
    return "Company name: $companyName, email: $email";
  }
}
