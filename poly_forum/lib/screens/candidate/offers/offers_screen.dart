import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatelessWidget {
  final CandidateUser user;

  const OffersScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CandidateOfferScreenCubit(),
        child: Body(user: user),
      ),
    );
  }
}
