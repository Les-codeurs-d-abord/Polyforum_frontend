import 'package:poly_forum/data/models/candidate_user_model.dart';

class CompanyWish {
  final int wishId;
  final int candidateProfileId;
  final int companyProfileId;
  final CandidateUser candidate;

  CompanyWish({
    required this.wishId,
    required this.candidateProfileId,
    required this.companyProfileId,
    required this.candidate,
  });

  factory CompanyWish.fromJson(Map<String, dynamic> json) {
    return CompanyWish(
      wishId: json['id'] ?? '',
      candidateProfileId: json['candidateProfileId'] ?? '',
      companyProfileId: json['companyProfileId'] ?? '',
      candidate: CandidateUser.fromJson(json['candidate'] ?? ''),
    );
  }
}
