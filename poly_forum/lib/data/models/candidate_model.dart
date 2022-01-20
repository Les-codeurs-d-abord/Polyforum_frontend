class Candidate {
  final String email;
  final String firstName;
  final String lastName;

  const Candidate({
    required this.email,
    required this.firstName,
    required this.lastName
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
  };

  @override
  String toString() {
    return "Candidate name : $firstName $lastName, email: $email";
  }
}
