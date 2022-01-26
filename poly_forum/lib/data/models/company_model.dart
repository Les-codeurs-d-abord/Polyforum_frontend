class Company {
  final int id;
  final String companyName;
  final String? logo;
  final String email;
  final int offersCount;
  final int wishesCount;

  Company({
    required this.id,
    required this.companyName,
    required this.logo,
    required this.email,
    required this.offersCount,
    required this.wishesCount,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['user']['id'],
      companyName: json['companyName'],
      logo: json['logo'],
      email: json['user']['email'],
      offersCount: json['offersCount'],
      wishesCount: json['wishesCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "logo": logo,
    "email": email,
    "offersCount": offersCount
  };

  @override
  String toString() {
    return "Company name: $companyName, email: $email";
  }
}
