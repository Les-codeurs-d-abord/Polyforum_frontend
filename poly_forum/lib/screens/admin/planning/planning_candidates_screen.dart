import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/admin_planning_candidates_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/admin/planning/components/candidates/body.dart';

class PlanningCandidatesScreen extends StatelessWidget {
  const PlanningCandidatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AdminPlanningCandidatesCubit(),
        child: const Body(),
      ),
    );
  }
}
