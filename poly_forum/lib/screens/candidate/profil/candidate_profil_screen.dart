import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/components/candidate_profil_btn.dart';

import 'components/body.dart';

class CandidateProfilScreen extends StatelessWidget {
  final CandidateUser user;

  const CandidateProfilScreen({required this.user, Key? key}) : super(key: key);

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
            CandidateProfilBtn(user: user),
          ],
          // child: LayoutBuilder(
          //   builder: (context, constraints) {
          //     if (constraints.maxWidth > 1080) {
          //       return buildWebVersion();
          //     } else {
          //       return buildWebVersion();
          //     }
          //   },
          // ),
        ),
      ),
      body: Body(user: user),
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
        CandidateProfilBtn(user: user),
      ],
    );
  }
}
