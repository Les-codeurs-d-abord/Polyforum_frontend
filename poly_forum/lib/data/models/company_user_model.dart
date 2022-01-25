import 'package:poly_forum/data/models/user_model.dart';

class CompanyUser extends User {
  final String companyName;
  final String phoneNumber;
  final String description;

  CompanyUser({
    required this.companyName,
    required this.phoneNumber,
    required this.description,
    required id,
    required email,
    required role,
  }) : super(id: id, email: email, role: role);

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
