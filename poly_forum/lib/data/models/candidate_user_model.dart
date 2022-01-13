import 'package:poly_forum/data/models/user_model.dart';

class CandidateUser extends User {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String description;

  const CandidateUser({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required email,
    required role,
  }) : super(email: email, role: role);

  factory CandidateUser.fromJson(Map<String, dynamic> json) {
    return CandidateUser(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'CANDIDAT',
    );
  }

  @override
  String toString() {
    return "FirstName: $firstName, LastName: $lastName";
  }
}
