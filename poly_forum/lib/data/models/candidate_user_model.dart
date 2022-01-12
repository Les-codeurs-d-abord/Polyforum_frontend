class CandidateUser {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String description;
  final String email;

  const CandidateUser({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.description,
    required this.email,
  });

  factory CandidateUser.fromJson(Map<String, dynamic> json) {
    return CandidateUser(
      firstName: json['companyProfileId'],
      lastName: json['company_profile']['companyName'],
      phoneNumber: json['offerLink'],
      address: json['name'],
      description: json['description'],
      email: json['phoneNumber'],
    );
  }

  @override
  String toString() {
    return "FirstName: $firstName, LastName: $lastName";
  }
}
