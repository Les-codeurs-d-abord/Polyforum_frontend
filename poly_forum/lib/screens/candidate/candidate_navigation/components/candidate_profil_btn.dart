import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/components/custom_avatar.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}

class CandidateProfilBtn extends StatelessWidget {
  final CandidateUser user;

  const CandidateProfilBtn({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: const [
              Icon(Icons.account_box_outlined),
              SizedBox(width: 20),
              Text("Profil"),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Icon(Icons.logout),
              SizedBox(width: 20),
              Text("Déconnexion"),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 0) {
        } else if (value == 1) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
              (Route<dynamic> route) => false);
        }
      },
      tooltip: "Profile",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.firstName + " " + user.lastName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(user.email),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 70,
                    child: CustomAvatar(user.firstName + " " + user.lastName),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
