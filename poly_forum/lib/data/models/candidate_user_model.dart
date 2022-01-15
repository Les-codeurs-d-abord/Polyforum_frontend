import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/data/models/user_model.dart';

class CandidateUser extends User {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String description;
  final List<String> links;
  final List<Tag> tags;

  const CandidateUser({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required email,
    required role,
    required this.links,
    required this.tags,
  }) : super(email: email, role: role);

  factory CandidateUser.fromJson(Map<String, dynamic> json) {
    List<Tag> tags = [];
    List<String> links = [];

    for (Map<String, dynamic> i in json['candidate_tags']) {
      tags.add(Tag.fromJson(i));
    }
    for (Map<String, dynamic> i in json['candidate_links']) {
      links.add(i['label'] ?? '');
    }

    return CandidateUser(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'CANDIDAT',
      links: links,
      tags: tags,
    );
  }

  @override
  String toString() {
    return "FirstName: $firstName, LastName: $lastName";
  }
}
