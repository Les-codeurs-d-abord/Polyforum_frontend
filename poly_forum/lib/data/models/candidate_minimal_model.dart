class CandidateMinimal {
  final int userId;
  final String firstName;
  final String lastName;

  CandidateMinimal(
      {required this.userId, required this.firstName, required this.lastName});

  factory CandidateMinimal.fromJson(Map<String, dynamic> json) {
    return CandidateMinimal(
        userId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName']);
  }
}
