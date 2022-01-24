import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/screens/shared/components/user/small_tag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CompanyOffersList extends StatefulWidget {
  final List<Offer> offersList;

  const CompanyOffersList({this.offersList = const [], Key? key}) : super(key: key);

  @override
  _CompanyOffersListState createState() => _CompanyOffersListState();
}

class _CompanyOffersListState extends State<CompanyOffersList> {
  late final Map<Offer, bool> offerExpanded = { for (var offer in widget.offersList) offer : false };

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (i, isOpen) => setState(() {
        offerExpanded[widget.offersList[i]] = !isOpen;
      }),
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 5),
      elevation: 6,
      children: [
        for (final offer in widget.offersList)
          ExpansionPanel(
            isExpanded: offerExpanded[offer] ?? false,
            headerBuilder: (context, isOpen) {
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.speaker_notes_outlined),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        offer.name,
                        style: const TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Créée le ${DateFormat("dd/MM/yyyy").format(offer.createdAt)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        )
                      ),
                    ),
                  ]
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
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
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: const Text(
                                      "Informations",
                                      style: TextStyle(
                                          fontSize: 18
                                      )
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.home)
                                    ),
                                    Expanded(
                                        child: (offer.address.isNotEmpty) ?
                                        Text(offer.address) :
                                        const Text(
                                          'Non renseigné',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.mail_outline)
                                    ),
                                    Expanded(
                                        child: (offer.email.isNotEmpty) ?
                                        Text(offer.email) :
                                        const Text(
                                          'Non renseigné',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.phone)
                                    ),
                                    Expanded(
                                        child: (offer.phoneNumber.isNotEmpty) ?
                                        Text(offer.phoneNumber) :
                                        const Text(
                                          'Non renseigné',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Icon(Icons.sticky_note_2_outlined)
                                    ),
                                    Flexible(
                                        fit: FlexFit.loose,
                                        child: (offer.offerFile.isNotEmpty) ?
                                        OutlinedButton(
                                          child: const Text("Document disponible"),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                          ),
                                          onPressed: () {
                                            launch("http://localhost:8080/api/res/${offer.offerFile}");
                                          },
                                        ) :
                                        const Text(
                                          "Document indisponible",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ]
                          ),
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
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          child: Icon(Icons.notes)
                                      ),
                                      Text(
                                          "Description",
                                          style: TextStyle(
                                            fontSize: 18,
                                          )
                                      ),
                                    ],
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 150,
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
                                        child: Text(
                                          offer.description,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                  ),
                                ]
                            ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        child: Icon(Icons.tag)
                                    ),
                                    const Text(
                                        "Tags",
                                        style: TextStyle(
                                          fontSize: 18,
                                        )
                                    ),
                                    if (offer.tags.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                            offer.tags.length.toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            )
                                        ),
                                      )
                                  ],
                                ),
                                if (offer.tags.isNotEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 10,
                                        runSpacing: 2,
                                        children: [
                                          for (var tag in offer.tags)
                                            SmallTag(tag)
                                        ]
                                    ),
                                  ) else Container(
                                  margin: const EdgeInsets.only(left: 10, top: 5),
                                  child: const Text(
                                      "Aucun tag",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )
                                  ),
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
                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                          child: Icon(Icons.link)
                                      ),
                                      const Text(
                                          "Liens",
                                          style: TextStyle(
                                            fontSize: 18,
                                          )
                                      ),
                                      if (offer.links.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                              offer.links.length.toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              )
                                          ),
                                        )
                                    ],
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: (offer.links.isNotEmpty == true) ?
                                      Column(
                                          children: [
                                            for (var link in offer.links)
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Row(
                                                            children: [
                                                              const Icon(Icons.arrow_right),
                                                              Flexible(
                                                                child: TextButton(
                                                                  child: Text(link),
                                                                  onPressed: () {
                                                                    launch(link);
                                                                  },
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                          ]
                                      ) :
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Text(
                                            "Aucun lien",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                              color: Colors.grey,
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}