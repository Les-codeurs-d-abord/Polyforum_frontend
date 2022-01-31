import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/resources/phases_repository.dart';

import 'components/body.dart';

class CompanyNavigationScreen extends StatelessWidget {
  const CompanyNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhaseCubit>(
          create: (context) => PhaseCubit(PhasesRepository()),
        ),
        BlocProvider<CompanyGetUserCubit>(
          create: (context) => CompanyGetUserCubit(),
        ),
      ],
      child: const Body(),
    );
  }
}
