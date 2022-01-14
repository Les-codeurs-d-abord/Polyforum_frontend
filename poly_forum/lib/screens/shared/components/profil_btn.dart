import 'package:flutter/material.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}

class ProfilBtn extends StatelessWidget {
  final String name;
  final String email;

  const ProfilBtn({required this.name, required this.email, Key? key})
      : super(key: key);

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
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(email),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 70,
                    child: InitialsAvatar(name),
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
