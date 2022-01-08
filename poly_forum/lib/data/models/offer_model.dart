import 'package:poly_forum/data/models/tag_model.dart';

class Offer {
  final String companyName;
  final String name;
  final String description;
  final String icon;
  final int companyId;
  final List<Tag> tags;

  const Offer({
    required this.companyName,
    required this.name,
    required this.description,
    required this.icon,
    required this.companyId,
    required this.tags,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    List<Tag> tags = [];

    for (Map<String, dynamic> i in json['offer_tags']) {
      tags.add(Tag.fromJson(i));
    }

    return Offer(
      companyName: json['companyName'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      companyId: json['companyId'],
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "name": name,
        "description": description,
        "icon": icon,
        "companyId": companyId,
      };

  @override
  String toString() {
    return "CompanyName: $companyName, Name: $name, CompanyId: $companyId, Icon: $icon";
  }
}
