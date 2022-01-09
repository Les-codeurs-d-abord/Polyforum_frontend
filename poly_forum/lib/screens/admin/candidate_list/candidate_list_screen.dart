import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_list_screen_cubit.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/admin/candidate_list/components/body.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateListScreen extends StatelessWidget {
  const CandidateListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: BlocProvider(
        create: (context) => CandidateListScreenCubit(CandidateRepository()),
        child: const Body(),
      ),
    );
  }
}
