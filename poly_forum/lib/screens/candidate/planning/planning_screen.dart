import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_planning_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/planning/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningScreen extends StatelessWidget {
  final CandidateUser user;

  const PlanningScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CandidatePlanningScreenCubit(),
        child: Body(
          user: user,
        ),
      ),
    );
  }
}
