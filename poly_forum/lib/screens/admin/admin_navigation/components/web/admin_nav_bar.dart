import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/utils/constants.dart';

import '../admin_profil_btn.dart';

class AdminNavBar extends StatelessWidget {
  final AdminUser user;
  final List<Widget> paths;
  final String title;

  const AdminNavBar(
      {required this.user, required this.paths, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      height: 70,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 0; i < paths.length; i++)
                    Row(
                      children: [
                        paths[i],
                        i < paths.length - 1
                            ? const Icon(Icons.arrow_right)
                            : const SizedBox.shrink(),
                      ],
                    ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              AdminProfilBtn(
                user: user,
              ),
            ],
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: kButtonColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
