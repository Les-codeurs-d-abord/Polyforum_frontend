import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_get_user_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/resources/phases_repository.dart';

import 'components/body.dart';

class AdminNavigationScreen extends StatelessWidget {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhaseCubit>(
          create: (context) => PhaseCubit(PhasesRepository()),
        ),
        BlocProvider<AdminGetUserCubit>(
          create: (context) => AdminGetUserCubit(),
        )
      ],
      child: const Body(),
    );
  }
}
