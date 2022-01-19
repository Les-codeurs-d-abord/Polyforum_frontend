import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/company_planning_screen_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/company/planning/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningScreen extends StatelessWidget {
  final CompanyUser user;

  const PlanningScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CompanyPlanningScreenCubit(),
        child: Body(
          user: user,
        ),
      ),
    );
  }
}
