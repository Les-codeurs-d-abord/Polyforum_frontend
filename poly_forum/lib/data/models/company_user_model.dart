import 'package:poly_forum/data/models/user_model.dart';

class CompanyUser extends User {
  final String companyName;
  final String phoneNumber;
  final String description;
  final String logo;
  final List<String> links;

  CompanyUser({
    required this.companyName,
    required this.phoneNumber,
    required this.description,
    required id,
    required email,
    required role,
    required this.logo,
    required this.links,
  }) : super(id: id, email: email, role: role);

  factory CompanyUser.fromJson(Map<String, dynamic> json) {
    List<String> links = [];

    for (Map<String, dynamic> i in json['company_links'] ?? []) {
      links.add(i['label'] ?? '');
    }

    return CompanyUser(
      id: json['id'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? '',
      companyName: json['companyName'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'ENTREPRISE',
      links: links,
    );
  }

  @override
  String toString() {
    return "CompanyName: $companyName";
  }
}
