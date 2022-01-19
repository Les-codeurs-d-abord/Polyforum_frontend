import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/components/candidate_profil_btn.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/body.dart';

class CandidateProfilScreen extends StatefulWidget {
  const CandidateProfilScreen({Key? key}) : super(key: key);

  @override
  State<CandidateProfilScreen> createState() => _CandidateProfilScreenState();
}

class _CandidateProfilScreenState extends State<CandidateProfilScreen> {
  CandidateUser? candidateUser;

  @override
  void initState() {
    super.initState();

    User? currentUser = Application.user;

    if (currentUser == null) {
      SharedPreferences.getInstance().then((value) async {
        try {
          final token = value.getString(kTokenPref);
          final user = await UserRepository().fetchUserFromToken(token!);

          if (user is CandidateUser) {
            Application.user = user;
            candidateUser = user;
          } else {
            Application.router.navigateTo(
              context,
              Routes.signInScreen,
              transition: TransitionType.fadeIn,
            );
          }
        } on Exception catch (e) {
          print(e.toString());
          Application.router.navigateTo(
            context,
            Routes.signInScreen,
            transition: TransitionType.fadeIn,
          );
        }
      });
    } else {
      if (currentUser is CandidateUser) {
        candidateUser = currentUser;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            "Mon profil",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            CandidateProfilBtn(user: candidateUser!),
          ],
        ),
      ),
      body: Body(user: candidateUser!),
    );
  }

  Widget buildWebVersion() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Profil",
            style: GoogleFonts.roboto(fontSize: 30),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: VerticalDivider(
            thickness: 1,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        CandidateProfilBtn(user: candidateUser!),
      ],
    );
  }
}
