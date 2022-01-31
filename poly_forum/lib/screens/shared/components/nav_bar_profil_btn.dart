import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/shared/components/user/initials_avatar.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}

class NavBarProfilBtn extends StatelessWidget {
  final String text;
  final String textTypeUser;
  final String uri;
  final Function onProfileSelected;

  const NavBarProfilBtn(
      {required this.text,
      required this.textTypeUser,
      required this.onProfileSelected,
      required this.uri,
      Key? key})
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
          onProfileSelected();
        } else if (value == 1) {
          SharedPreferences.getInstance()
              .then((value) => value.setString(kTokenPref, ""));
          Application.router.navigateTo(
            context,
            Routes.signInScreen,
            clearStack: true,
            transition: TransitionType.fadeIn,
          );
        }
      },
      tooltip: "Profil",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 60,
                    child: ProfilePicture(
                        uri: uri, name: text, withListenerEventOnChange: true),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kButtonColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down_outlined),
                  ],
                ),
                Text(
                  textTypeUser,
                  style: const TextStyle(
                    color: Colors.grey,
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
