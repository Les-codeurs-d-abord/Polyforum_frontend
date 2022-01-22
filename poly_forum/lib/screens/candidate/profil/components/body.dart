import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/update_candidate_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/candidate/profil/components/editable_avatar.dart';
import 'package:poly_forum/screens/candidate/profil/components/profil_form.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: SizedBox(
                  width: 1200,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Modifier mon profil",
                          style: TextStyle(
                            color: kButtonColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlocProvider(
                          create: (context) => UpdateCandidateCubit(),
                          child: ProfilForm(user: user),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
