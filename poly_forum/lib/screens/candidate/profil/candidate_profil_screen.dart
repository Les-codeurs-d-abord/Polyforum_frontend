import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'components/body.dart';

class CandidateProfilScreen extends StatelessWidget {
  final CandidateUser candidateUser;

  const CandidateProfilScreen({required this.candidateUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: candidateUser),
    );
  }
}
