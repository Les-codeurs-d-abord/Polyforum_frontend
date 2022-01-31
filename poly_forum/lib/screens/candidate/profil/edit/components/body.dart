import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/update_candidate_cubit.dart';
import 'package:poly_forum/cubit/file_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/profil/edit/components/profil_form.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UpdateCandidateCubit(),
          ),
          BlocProvider(
            create: (context) => FileCubit(),
          ),
        ],
        child: OfferForm(user: user),
      ),
      width: 1200,
    );
  }
}
