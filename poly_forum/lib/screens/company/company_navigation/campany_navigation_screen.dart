import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_phase_cubit.dart';

import 'components/body.dart';

class CompanyNavigationScreen extends StatelessWidget {
  const CompanyNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CompanyPhaseCubit>(
          create: (context) => CompanyPhaseCubit(),
        ),
        BlocProvider<CompanyGetUserCubit>(
          create: (context) => CompanyGetUserCubit(),
        ),
      ],
      child: const Body(),
    );
  }
}
