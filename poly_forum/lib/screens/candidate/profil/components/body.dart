import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/offers/components/tags.dart';
import 'package:poly_forum/screens/candidate/profil/components/editable_avatar.dart';
import 'package:poly_forum/screens/candidate/profil/components/profil_form.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  final CandidateUser user;

  const Body({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
/*         decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ), */

      child: ProfilForm(user: user),
    );
  }
}
