class Company {
  final String companyName;
  final String? logo;
  final String email;

  const Company({
    required this.companyName,
    required this.logo,
    required this.email,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['companyName'],
      logo: json['logo'],
      email: json['user']['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "logo": logo,
    "email": email,
  };

  @override
  String toString() {
    return "Company name: $companyName, email: $email";
  }
}
