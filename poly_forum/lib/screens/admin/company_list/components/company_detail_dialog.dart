import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/data/models/company_detail_model.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetailDialog extends StatefulWidget {
  final int companyId;

  const CompanyDetailDialog(this.companyId, {Key? key}) : super(key: key);

  @override
  State<CompanyDetailDialog> createState() => _CompanyDetailDialogState();
}

class _CompanyDetailDialogState extends State<CompanyDetailDialog> {
  CompanyDetail? companyDetail;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyFormCubit>(context)
        .getCompanyDetail(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyFormCubit, CompanyFormState>(
        listener: (context, state) {
      if (state is CompanyDetailLoaded) {
        companyDetail = state.company;
      }
    }, builder: (context, state) {
      if (state is CompanyFormLoading) {
        return buildCompanyDetailDialog(context, isLoading: true);
      } else if (state is CompanyDetailLoaded) {
        return buildCompanyDetailDialog(context, companyDetail: companyDetail);
      } else if (state is CompanyFormError) {
        return buildCompanyDetailDialog(context, error: state.errorMessage);
      } else {
        return buildCompanyDetailDialog(context);
      }
    });
  }

  buildCompanyDetailDialog(BuildContext context,
      {CompanyDetail? companyDetail,
      bool isLoading = false,
      String error = ''}) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Détail de l'entreprise ${companyDetail?.companyName}",
              style: const TextStyle(fontSize: 22),
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
          height: 500,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
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
                            CachedNetworkImage(
                              imageUrl: companyDetail?.logo ?? '',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) {
                                return InitialsAvatar(
                                    companyDetail?.companyName ?? '?');
                              },
                              width: 100,
                              height: 100,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(companyDetail?.companyName ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                            const Text("Entreprise",
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
                                  child: Icon(Icons.mail)),
                              Expanded(
                                  child:
                                      (companyDetail?.email.isNotEmpty == true)
                                          ? Text(companyDetail?.email ?? '')
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
                                  child: (companyDetail
                                              ?.phoneNumber?.isNotEmpty ==
                                          true)
                                      ? Text(companyDetail?.phoneNumber ?? '')
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
                        ]),
                  ),
                  const VerticalDivider(thickness: 1),
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
                                height: 300,
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
                                    companyDetail?.description ?? '',
                                    textAlign: TextAlign.justify,
                                  ),
                                )),
                            const Text("Liens", style: TextStyle(fontSize: 18)),
                            Container(
                                child: (companyDetail?.links.isNotEmpty == true)
                                    ? Column(children: [
                                        for (var link
                                            in companyDetail?.links ?? [])
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Wrap(children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Icon(Icons.link),
                                                ),
                                                TextButton(
                                                  child: Text(link,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  onPressed: () {
                                                    launch(link);
                                                  },
                                                ),
                                              ]))
                                            ],
                                          )
                                      ])
                                    : const Text("Aucun lien",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          color: Colors.grey,
                                        )))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
