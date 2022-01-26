import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/resources/phases_repository.dart';

import 'components/body.dart';

class CandidateNavigationScreen extends StatelessWidget {
  const CandidateNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhaseCubit>(
          create: (context) => PhaseCubit(PhasesRepository()),
        ),
        BlocProvider<CandidateGetUserCubit>(
          create: (context) => CandidateGetUserCubit(),
        ),
      ],
      child: const Body(),
    );
  }
}
