import 'package:poly_forum/data/models/tag_model.dart';

class Offer {
  final String name;
  final String description;
  final String offerLink;
  final String phoneNumber;
  final String address;
  final String email;
  final String companyName;
  final int companyId;
  final List<String> links;
  final List<Tag> tags;

  const Offer({
    required this.companyId,
    required this.companyName,
    required this.offerLink,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.links,
    required this.tags,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    List<Tag> tags = [];
    List<String> links = [];

    for (Map<String, dynamic> i in json['offer_tags']) {
      tags.add(Tag.fromJson(i));
    }
    for (Map<String, dynamic> i in json['offer_links']) {
      links.add(i['label'] ?? '');
    }

    return Offer(
      companyId: json['companyProfileId'] ?? '',
      companyName: json['company_profile']['companyName'] ?? 0,
      offerLink: json['offerLink'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      links: links,
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "companyId": companyId,
      };

  @override
  String toString() {
    return "Name: $name, CompanyId: $companyId";
  }
}
