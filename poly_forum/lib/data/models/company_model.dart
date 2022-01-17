class Company {
  final int id;
  final String companyName;
  final String? logo;
  final String email;

  Company({
    required this.id,
    required this.companyName,
    required this.logo,
    required this.email,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['user']['id'],
      companyName: json['companyName'],
      logo: json['logo'],
      email: json['user']['email'],
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
