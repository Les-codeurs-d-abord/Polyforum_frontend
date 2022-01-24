class Offer {
  final String name;
  final String description;
  final String offerFile;
  final String phoneNumber;
  final String address;
  final String email;
  final String companyName;
  final int companyId;
  final List<String> links;
  final List<String> tags;
  final DateTime createdAt;

  const Offer({
    required this.companyId,
    required this.companyName,
    required this.offerFile,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.links,
    required this.tags,
    required this.createdAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    List<String> links = [];
    List<String> tags = [];

    for (Map<String, dynamic> i in json['offer_tags']) {
      tags.add(i['label'] ?? '');
    }
    for (Map<String, dynamic> i in json['offer_links']) {
      links.add(i['label'] ?? '');
    }

    return Offer(
      companyId: json['companyProfileId'] ?? '',
      companyName: json['company_profile']?['companyName'] ?? '',
      offerFile: json['offerFile'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      links: links,
      tags: tags,
      createdAt: DateTime.parse(json['createdAt']),
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
