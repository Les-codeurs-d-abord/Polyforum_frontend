import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/candidate_profil_btn.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateNavBar extends StatelessWidget {
  final CandidateUser user;
  final Function onProfileSelected;
  final List<String> paths;

  const CandidateNavBar(
      {required this.user,
      required this.onProfileSelected,
      required this.paths,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
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
      child: Expanded(
        child: Row(
          children: [
            Row(
              children: [
                for (int i = 0; i < paths.length - 1; i++)
                  Row(
                    children: [
                      Text(
                        paths[i],
                        style: TextStyle(color: kButtonColor),
                      ),
                      const Icon(Icons.arrow_right),
                      Text(
                        paths[i + 1],
                        style: TextStyle(color: kButtonColor),
                      ),
                    ],
                  ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            CandidateProfilBtn(
              user: user,
              onProfileSelected: onProfileSelected,
            ),
          ],
        ),
      ),
    );
  }
}
