class Offer {
  final int id;
  String name;
  String description;
  final String offerFile;
  String phoneNumber;
  String address;
  String email;
  final String companyName;
  final int companyId;
  final int companyUserId;
  List<String> links;
  List<String> tags;
  final DateTime createdAt;
  final String logoUri;

  Offer({
    required this.id,
    required this.companyId,
    required this.companyUserId,
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
    required this.logoUri,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    List<String> links = [];
    List<String> tags = [];

    for (Map<String, dynamic> i in json['offer_tags'] ?? []) {
      tags.add(i['label'] ?? '');
    }
    for (Map<String, dynamic> i in json['offer_links'] ?? []) {
      links.add(i['label'] ?? '');
    }

    return Offer(
      id: json['id'] ?? 0,
      companyId: json['companyProfileId'] ?? 0,
      companyUserId: json['company_profile']?['userId'] ?? 0,
      companyName: json['company_profile']?['companyName'] ?? '',
      offerFile: json['offerFile'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      links: links,
      tags: tags,
      logoUri: json['company_profile']?['logo'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "companyProfileId": companyId,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "links": links,
        "tags": tags,
      };

  @override
  String toString() {
    return "Name: $name, CompanyId: $companyId";
  }

  @override
  bool operator ==(Object other) {
    return other is Offer && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
