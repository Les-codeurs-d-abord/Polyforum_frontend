import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  final void Function(Company) detailEvent;
  final void Function(Company) offersEvent;
  final void Function(Company) editEvent;
  final void Function(Company) deleteEvent;

  const CompanyCard({
    Key? key,
    required this.company,
    required this.detailEvent,
    required this.offersEvent,
    required this.editEvent,
    required this.deleteEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () => detailEvent(company),
        child: SizedBox(
          height: 75,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ProfilePicture(
                    uri: company.logo ?? '',
                    name: company.companyName,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 12,
                  child: Text(company.companyName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                ),
                const Spacer(),
                Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: getColorByStatus(company.status),
                          size: 15,
                        ),
                      ],
                    )
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: Text(
                    company.offersCount.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: Text(
                    company.wishesCount.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                              Icon(Icons.speaker_notes_outlined),
                              SizedBox(width: 20),
                              Text("Offres"),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 1,
                          enabled: BlocProvider.of<PhaseCubit>(context)
                                  .getCurrentPhase() !=
                              Phase.planning,
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
                          value: 2,
                          enabled: BlocProvider.of<PhaseCubit>(context)
                                  .getCurrentPhase() !=
                              Phase.planning,
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
                        switch (value) {
                          case 0:
                            return offersEvent(company);
                          case 1:
                            return editEvent(company);
                          case 2:
                            return deleteEvent(company);
                        }
                      },
                      tooltip: "Actions",
                      child: Container(
                          padding: const EdgeInsets.all(7),
                          child: const Icon(Icons.more_horiz)),
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

  Color getColorByStatus(String status) {
    switch (status) {
      case "Jamais connecté":
        return Colors.red;
      case "Incomplet":
        return Colors.orange;
      case "Complet":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
