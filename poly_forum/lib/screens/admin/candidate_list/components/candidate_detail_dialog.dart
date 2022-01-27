import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/data/models/candidate_detail_model.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
import 'package:poly_forum/screens/shared/components/user/small_tag.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateDetailDialog extends StatefulWidget {
  final int candidateId;

  const CandidateDetailDialog(this.candidateId, {Key? key}) : super(key: key);

  @override
  _CandidateDetailDialogState createState() => _CandidateDetailDialogState();
}

class _CandidateDetailDialogState extends State<CandidateDetailDialog> {
  CandidateDetail? candidateDetail;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateFormCubit>(context).getCandidateDetail(widget.candidateId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateFormCubit, CandidateFormState>(
        listener: (context, state) {
          if (state is CandidateDetailLoaded) {
            candidateDetail = state.candidate;
          }
        },
        builder: (context, state) {
          if (state is CandidateFormLoading) {
            return buildCandidateDetailDialog(context, isLoading: true);
          } else if (state is CandidateDetailLoaded) {
            return buildCandidateDetailDialog(context, candidateDetail: candidateDetail);
          } else if (state is CandidateFormError) {
            return buildCandidateDetailDialog(context, error: state.errorMessage);
          } else {
            return buildCandidateDetailDialog(context);
          }
        }
    );
  }

  buildCandidateDetailDialog(BuildContext context, {CandidateDetail? candidateDetail, bool isLoading = false, String error = ''}) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Détail du candidat ${candidateDetail?.lastName ?? ''} ${candidateDetail?.firstName ?? ''}",
              style: const TextStyle(
                  fontSize: 22
              ),
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
          child: isLoading ?
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )
              ]
          ) :
          error.isNotEmpty ?
          Text(
            error,
            style: const TextStyle(
                color: Colors.red,
                fontSize: 18
            ),
          ) :
          SingleChildScrollView(
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
                                  child: Column(
                                      children: [
                                        ProfilePicture(
                                            uri: candidateDetail?.logo ?? '',
                                            defaultText: "${candidateDetail?.lastName ?? ''} ${candidateDetail?.firstName ?? ''}",
                                            width: 100,
                                            height: 100
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                              "${candidateDetail?.lastName ?? ''} ${candidateDetail?.firstName ?? ''}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              )
                                          ),
                                        ),
                                        const Text(
                                            "Candidat",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: const Text(
                                    "Informations",
                                    style: TextStyle(
                                        fontSize: 20
                                    )
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     const Padding(
                              //         padding: EdgeInsets.all(10),
                              //         child: Icon(Icons.home)
                              //     ),
                              //     Expanded(
                              //         child: (candidateDetail?.address.isNotEmpty == true) ?
                              //         Text(candidateDetail?.address ?? '') :
                              //         const Text(
                              //           'Non renseigné',
                              //           style: TextStyle(
                              //             fontStyle: FontStyle.italic,
                              //             fontSize: 15,
                              //             color: Colors.grey,
                              //           ),
                              //         )
                              //     )
                              //   ],
                              // ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.mail_outline)
                                  ),
                                  Flexible(
                                      child: (candidateDetail?.email.isNotEmpty == true) ?
                                      TextButton(
                                        child: Text(candidateDetail?.email ?? ''),
                                        onPressed: () => launch("mailto:${candidateDetail?.email ?? ''}"),
                                      ) :
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
                                      child: (candidateDetail?.phoneNumber.isNotEmpty == true) ?
                                      Text(candidateDetail?.phoneNumber ?? '') :
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
                                      child: (candidateDetail?.cv.isNotEmpty == true) ?
                                      OutlinedButton(
                                        child: const Text("CV disponible"),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                        ),
                                        onPressed: () {
                                          launch("http://localhost:8080/api/res/${candidateDetail?.cv}");
                                        },
                                      ) :
                                      const Text(
                                        "CV indisponible",
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
                                          fontSize: 20,
                                        )
                                    ),
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
                                      child: Text(
                                        candidateDetail?.description ?? '',
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
                                        fontSize: 20,
                                      )
                                  ),
                                  if (candidateDetail?.tags.isNotEmpty == true)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                          candidateDetail!.tags.length.toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          )
                                      ),
                                    )
                                ],
                              ),
                              if (candidateDetail?.tags.isNotEmpty == true)
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 2,
                                      children: [
                                        for (var tag in candidateDetail?.tags ?? [])
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
                                          fontSize: 20,
                                        )
                                    ),
                                    if (candidateDetail?.links.isNotEmpty == true)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                            candidateDetail!.links.length.toString(),
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
                                    child: (candidateDetail?.links.isNotEmpty == true) ?
                                    Column(
                                        children: [
                                          for (var link in candidateDetail?.links ?? [])
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
          )
      ),
    );
  }
}
