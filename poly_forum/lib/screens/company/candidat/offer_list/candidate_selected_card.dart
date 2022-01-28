import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/admin/candidate_list/components/candidate_detail_dialog.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';

class CandidateSelectedCard extends StatelessWidget {
  final CandidateUser candidate;

  const CandidateSelectedCard({required this.candidate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ProfilePicture(
                    uri: "",
                    defaultText: candidate.firstName + " " + candidate.lastName,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 10),
                  Text(candidate.firstName + " " + candidate.lastName),
                  const Spacer(),
                  const Text(
                    "Ouvrir",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_outlined),
                ],
              ),
              const Divider(),
              candidate.tags.isNotEmpty
                  ? Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var tag in candidate.tags) Tags(text: tag),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
