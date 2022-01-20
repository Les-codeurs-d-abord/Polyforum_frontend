import 'package:poly_forum/data/models/user_model.dart';

class CandidateDetail extends User {
  final String lastName;
  final String firstName;
  final String phoneNumber;
  final String address;
  final String description;
  final String logo;
  final String cv;
  final int userId;
  final List<String> links;
  final List<String> tags;

  CandidateDetail({
    required id,
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.logo,
    required this.cv,
    required this.userId,
    required email,
    required role,
    required this.links,
    required this.tags,
  }) : super(id: id, email: email, role: role);

  factory CandidateDetail.fromJson(Map<String, dynamic> json) {
    List<String> links = [];
    List<String> tags = [];

    for (Map<String, dynamic> link in json['candidate_links'] ?? []) {
      links.add(link['label']);
    }
    for (Map<String, dynamic> tag in json['candidate_tags'] ?? []) {
      tags.add(tag['label']);
    }

    return CandidateDetail(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      cv: json['cv'] ?? '',
      userId: json['user']['id'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'CANDIDAT',
      tags: tags,
      links: links,
    );
  }

  @override
  String toString() {
    return "FirstName: $firstName, LastName: $lastName";
  }
}
