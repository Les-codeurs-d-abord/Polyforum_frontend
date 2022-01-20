class Candidate {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;

  const Candidate(
      {required this.userId,
      required this.email,
      required this.firstName,
      required this.lastName});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      userId: json['user']['id'],
      email: json['user']['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };

  @override
  String toString() {
    return "Candidate name : $firstName $lastName, email: $email, id $userId";
  }
}
