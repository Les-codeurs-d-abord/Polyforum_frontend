import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/admin/dashboard/components/body.dart';
import 'package:poly_forum/utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: BlocProvider(
        create: (context) => DashboardCubit(CompanyRepository(), CandidateRepository()),
        child: const Body(),
      ),
    );
  }
}
