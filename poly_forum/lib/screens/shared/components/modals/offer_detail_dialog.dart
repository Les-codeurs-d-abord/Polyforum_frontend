import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDetailDialog extends StatelessWidget {
  final Offer offer;

  const OfferDetailDialog({required this.offer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                  text: "Détail de l'offre: ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: offer.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
          ),
          InkResponse(
            radius: 20,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
      content: SizedBox(
          width: 900,
          height: 470,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Column(children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ProfilePicture(
                                    uri: offer.logoUri,
                                    name: offer.companyName,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text("${offer.name}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                                const Text("Offres",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey)),
                              ])),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: const Text("Informations",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.mail_outline)),
                                  Flexible(
                                      child: (offer.email.isNotEmpty == true)
                                          ? TextButton(
                                              child: Text(offer.email),
                                              onPressed: () => launch(
                                                  "mailto:${offer.email}"),
                                            )
                                          : const Text(
                                              'Non renseigné',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ))
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.phone)),
                                  Expanded(
                                      child:
                                          (offer.phoneNumber.isNotEmpty == true)
                                              ? Text(offer.phoneNumber)
                                              : const Text(
                                                  'Non renseigné',
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ))
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(10),
                                      child:
                                          Icon(Icons.sticky_note_2_outlined)),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      child: (offer.offerFile.isNotEmpty ==
                                              true)
                                          ? OutlinedButton(
                                              child:
                                                  const Text("CV disponible"),
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                launch(
                                                    "http://$kServer/api/res/${offer.offerFile}");
                                              },
                                            )
                                          : const Text(
                                              "CV indisponible",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ))
                                ],
                              ),
                            ]),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        endIndent: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(Icons.notes)),
                                    Text("Description",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                  ],
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 250,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: SingleChildScrollView(
                                      primary: false,
                                      child: Text(
                                        offer.description,
                                        textAlign: TextAlign.justify,
                                      ),
                                    )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Icon(Icons.tag)),
                                  const Text("Tags",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  if (offer.tags.isNotEmpty == true)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(offer.tags.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          )),
                                    )
                                ],
                              ),
                              if (offer.tags.isNotEmpty == true)
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Wrap(
                                      // alignment: WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 4,
                                      children: [
                                        for (var tag in offer.tags)
                                          Tags(text: tag)
                                      ]),
                                )
                              else
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: const Text("Aucun tag",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )),
                                )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 45),
                            alignment: AlignmentDirectional.topStart,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(Icons.link)),
                                    const Text("Liens",
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    if (offer.links.isNotEmpty == true)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child:
                                            Text(offer.links.length.toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                )),
                                      )
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: (offer.links.isNotEmpty == true)
                                        ? Column(children: [
                                            for (var link in offer.links)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Row(children: [
                                                      const Icon(
                                                          Icons.arrow_right),
                                                      Flexible(
                                                        child: TextButton(
                                                          child: Text(link),
                                                          onPressed: () {
                                                            launch(link);
                                                          },
                                                        ),
                                                      ),
                                                    ]))
                                                  ],
                                                ),
                                              )
                                          ])
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text("Aucun lien",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                )),
                                          ))
                              ],
                            ),
                          ),
                        )
                      ]),
                )
              ],
            ),
          )),
    );
  }
}
