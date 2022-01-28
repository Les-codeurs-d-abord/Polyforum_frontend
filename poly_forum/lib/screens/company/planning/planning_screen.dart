import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/company_planning_screen_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/screens/company/planning/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CompanyUser user =
        BlocProvider.of<CompanyGetUserCubit>(context).getUser();

    return BlocProvider(
      create: (context) => CompanyPlanningScreenCubit(),
      child: Body(
        user: user,
      ),
    );
  }
}
