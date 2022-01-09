class Company {
  final String email;
  final String companyName;

  const Company({
    required this.email,
    required this.companyName
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      email: json['email'],
      companyName: json['companyName']
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "companyName": companyName
  };

  @override
  String toString() {
    return "Company name: $companyName, email: $email";
  }
}
