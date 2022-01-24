import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';

import 'components/body.dart';

class ChoicesScreen extends StatelessWidget {
  final CandidateUser user;

  const ChoicesScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CandidateChoicesCubit(),
      child: Body(user: user),
    );
  }
}
