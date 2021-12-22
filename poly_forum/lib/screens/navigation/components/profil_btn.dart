import 'package:flutter/material.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}

class ProfilBtn extends StatelessWidget {
  const ProfilBtn({Key? key}) : super(key: key);

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
      tooltip: "Menu déroulant",
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: const [
            Icon(
              Icons.account_circle_outlined,
              size: 40,
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
