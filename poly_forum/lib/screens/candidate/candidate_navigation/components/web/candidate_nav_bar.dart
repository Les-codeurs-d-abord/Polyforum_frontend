import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/candidate_profil_btn.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateNavBar extends StatelessWidget {
  final CandidateUser user;
  final Function onProfileSelected;
  final List<Widget> paths;
  final String title;

  const CandidateNavBar(
      {required this.user,
      required this.onProfileSelected,
      required this.paths,
      required this.title,
      Key? key})
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
      child: Row(
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
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: kButtonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ),
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
    );
  }
}
