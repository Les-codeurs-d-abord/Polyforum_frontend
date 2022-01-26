import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/companies/admin_planning_companies_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/admin/planning/components/companies/body.dart';

class PlanningCompaniesScreen extends StatelessWidget {
  const PlanningCompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => AdminPlanningCompaniesCubit(),
            child: const Body()));
  }
}
