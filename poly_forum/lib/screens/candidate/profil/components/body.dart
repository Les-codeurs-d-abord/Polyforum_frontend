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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Modifier le profil",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              EditableAvatar(user.firstName + " " + user.lastName),
              ProfilForm(),
            ],
          ),
        ),
        // child: IntrinsicHeight(
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Text("Description"),
        //             Expanded(
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.grey),
        //                   borderRadius: BorderRadius.all(
        //                     Radius.circular(5),
        //                   ),
        //                 ),
        //                 child: Text(user.description),
        //               ),
        //             ),
        //             TextButton(
        //               style: TextButton.styleFrom(
        //                 primary: Colors.white,
        //                 backgroundColor: kButtonColor,
        //                 onSurface: Colors.grey,
        //               ),
        //               onPressed: () {},
        //               child: const Padding(
        //                 padding:
        //                     EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //                 child: Text(
        //                   "Ouvrir le CV",
        //                   style: TextStyle(
        //                     fontSize: 26,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       const VerticalDivider(
        //         color: Colors.black,
        //         thickness: 1,
        //       ),
        //       Expanded(
        //         child: Column(
        //           children: [
        //             buildInfo(),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget buildInfo() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contacts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.phone,
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(user.phoneNumber),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.mail_outline,
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(user.email),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Lieu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(user.address),
              )
            ],
          ),
          const SizedBox(height: 20),
          user.links.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Liens",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (var link in user.links)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.link_outlined,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              child: Text(
                                link,
                                style: const TextStyle(color: Colors.blue),
                              ),
                              onTap: () => launch(link),
                            ),
                          )
                        ],
                      ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          user.tags.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var tag in user.tags) Tags(text: tag.label),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
