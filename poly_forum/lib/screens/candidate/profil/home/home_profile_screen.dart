import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/home/home_profile_card.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';

class HomeProfileScreen extends StatelessWidget {
  final Function onEditProfilePressed;
  final Function onChangePasswordPressed;

  const HomeProfileScreen(
      {required this.onEditProfilePressed,
      required this.onChangePasswordPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 50,
            runSpacing: 50,
            children: [
              HomeProfileCard(
                title: "Modifier mon profil",
                text:
                    "Cette page te permettra de d'ajouter ou de modifier tes informations personnelles obligatoire tel que ton numéro de téléphone, ton CV, ta description ainsi que d'autres informations facultatives.",
                iconData: Icons.edit,
                onPressed: onEditProfilePressed,
              ),
              HomeProfileCard(
                title: "Modifier mon mot de passe",
                text: "Cette page te permettra de changer ton mot de passe.",
                iconData: Icons.edit,
                onPressed: onChangePasswordPressed,
              ),
            ],
          ),
        ),
      ],
    );

    return BaseScreen(
      child: child,
      width: 1200,
    );
  }
}
