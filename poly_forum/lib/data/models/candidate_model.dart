class Candidate {
  final String email;
  final String firstName;
  final String lastName;
  final String status;

  const Candidate(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.status});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "status": status
      };

  @override
  String toString() {
    return "Candidate name : $firstName $lastName, email: $email, status: $status";
  }
}
