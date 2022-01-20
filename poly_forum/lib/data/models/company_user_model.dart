import 'package:poly_forum/data/models/user_model.dart';

class CompanyUser extends User {
  final int id;
  final String companyName;
  final String phoneNumber;
  final String description;

  const CompanyUser({
    required this.id,
    required this.companyName,
    required this.phoneNumber,
    required this.description,
    required email,
    required role,
  }) : super(email: email, role: role);

  factory CompanyUser.fromJson(Map<String, dynamic> json) {
    return CompanyUser(
      id: json['id'],
      phoneNumber: json['phoneNumber'] ?? '',
      companyName: json['companyName'] ?? '',
      description: json['description'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'ENTREPRISE',
    );
  }

  @override
  String toString() {
    return "CompanyName: $companyName";
  }
}
