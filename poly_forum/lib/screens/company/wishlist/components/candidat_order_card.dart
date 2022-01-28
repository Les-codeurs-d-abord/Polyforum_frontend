import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/admin/candidate_list/components/candidate_detail_dialog.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandidatOrderCard extends StatelessWidget {
  final CandidateUser candidate;
  final int rank;

  const CandidatOrderCard(
      {required this.candidate, required this.rank, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => CandidateFormCubit(CandidateRepository()),
                child: CandidateDetailDialog(candidate.id),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 30, top: 10, left: 10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfilePicture(
                              uri: "", defaultText: candidate.firstName),
                          const SizedBox(width: 10),
                          Text(
                            candidate.firstName + " " + candidate.lastName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (int index = 0;
                                  index < candidate.tags.length;
                                  index++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Tags(
                                    text: candidate.tags[index],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: kSecondaryColor,
                radius: 25,
                child: Text(
                  "${rank + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
