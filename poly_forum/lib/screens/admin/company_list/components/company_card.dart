import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/screens/components/custom_avatar.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  final void Function(Company) detailEvent;
  final void Function(Company) editEvent;
  final void Function(Company) deleteEvent;

  const CompanyCard({
    Key? key,
    required this.company,
    required this.detailEvent,
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
                CachedNetworkImage(
                  imageUrl: company.logo ?? '',
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CustomAvatar(company.companyName),
                  width: 50,
                  height: 50,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                      company.companyName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      )
                  ),
                ),
                const Spacer(),
                const Expanded(
                  child: Text(
                    "offer count",
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
                            return editEvent(company);
                          case 1:
                            return deleteEvent(company);
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
