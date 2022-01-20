import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';

class CandidateCard extends StatelessWidget {
  final CandidateUser candidate;
  final void Function(CandidateUser) detailEvent;
  final void Function(CandidateUser) editEvent;
  final void Function(CandidateUser) deleteEvent;

  const CandidateCard({
    Key? key,
    required this.candidate,
    required this.detailEvent,
    required this.editEvent,
    required this.deleteEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () => detailEvent(candidate),
        child: SizedBox(
          height: 75,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: '', // TODO
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => InitialsAvatar(candidate.lastName + " " + candidate.firstName),
                  width: 50,
                  height: 50,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                      candidate.lastName + " " + candidate.firstName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      )
                  ),
                ),
                const Spacer(),
                const Expanded(
                  child: Text(
                    "Complétion", // TODO
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Material(
                    color: Colors.transparent,
                    child: PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: const [
                              Icon(Icons.edit),
                              SizedBox(width: 20),
                              Text("Modifier"),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: const [
                              Icon(Icons.close),
                              SizedBox(width: 20),
                              Text("Supprimer"),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        switch(value) {
                          case 0:
                            return editEvent(candidate);
                          case 1:
                            return deleteEvent(candidate);
                        }
                      },
                      tooltip: "Actions",
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          child: const Icon(Icons.more_horiz)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
