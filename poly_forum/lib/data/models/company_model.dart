class Company {
  final int id;
  final String companyName;
  final String? logo;
  final String email;
  final String status;
  final int offersCount;
  final int wishesCount;

  Company({
    required this.id,
    required this.companyName,
    required this.logo,
    required this.email,
    required this.status,
    required this.offersCount,
    required this.wishesCount,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['user']['id'] ?? 0,
      companyName: json['companyName'] ?? '',
      logo: json['logo'] ?? '',
      email: json['user']['email'] ?? '',
      status: json['status'] ?? '',
      offersCount: json['offersCount'] ?? 0,
      wishesCount: json['wishesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "logo": logo,
    "email": email,
  };

  @override
  String toString() {
    return "Company name: $companyName, email: $email";
  }
}
