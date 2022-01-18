import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/data/models/user_model.dart';

class CandidateUser extends User {
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String description;
  List<String> links;
  List<String> tags;

  CandidateUser({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required id,
    required email,
    required role,
    required this.links,
    required this.tags,
  }) : super(id: id, email: email, role: role);

  factory CandidateUser.fromJson(Map<String, dynamic> json) {
    List<String> tags = [];
    List<String> links = [];

    for (Map<String, dynamic> i in json['candidate_tags']) {
      tags.add(i['tag']);
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
      id: json["id"],
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'CANDIDAT',
      links: links,
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'description': description,
      'email': email,
      'role': role,
      'links': links,
      'tags': tags,
    };
  }

  @override
  String toString() {
    return "FirstName: $firstName, LastName: $lastName";
  }
}
