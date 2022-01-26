import 'dart:convert';

import 'package:poly_forum/data/models/user_model.dart';

class CandidateUser extends User {
  final int candidateId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String description;
  final String logo;
  final String status;
  final List<String> links;
  final List<String> tags;
  final int wishesCount;
  final String cv;

  CandidateUser({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.candidateId,
    required id,
    required this.logo,
    required this.status,
    required email,
    required role,
    required this.links,
    required this.tags,
    required this.wishesCount,
    required this.cv,
  }) : super(id: id, email: email, role: role);

  factory CandidateUser.fromJson(Map<String, dynamic> json) {
    List<String> tags = [];
    List<String> links = [];

    for (Map<String, dynamic> i in json['candidate_tags'] ?? []) {
      tags.add(i['label'] ?? '');
    }
    for (Map<String, dynamic> i in json['candidate_links'] ?? []) {
      links.add(i['label'] ?? '');
    }

    return CandidateUser(
      id: json['user']['id'],
      candidateId: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      status: json['status'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'CANDIDAT',
      links: links,
      tags: tags,
      wishesCount: json['wishesCount'] ?? 0,
      cv: json['cv'] ?? '',
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
    return jsonEncode(toJson());
  }
}
