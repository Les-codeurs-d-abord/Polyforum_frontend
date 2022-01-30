import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/data/models/company_detail_model.dart';
import 'package:poly_forum/screens/shared/components/user/profile_picture.dart';
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
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      )
                    ])
              : error.isNotEmpty
                  ? Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    )
                  : SingleChildScrollView(
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
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: ProfilePicture(
                                          uri: companyDetail?.logo ?? '',
                                          name:
                                              companyDetail?.companyName ?? '',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            companyDetail?.companyName ?? '',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      const Text("Entreprise",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey)),
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
                                            child: (companyDetail
                                                        ?.email.isNotEmpty ==
                                                    true)
                                                ? TextButton(
                                                    child: Text(
                                                        companyDetail?.email ??
                                                            ''),
                                                    onPressed: () => launch(
                                                        "mailto:${companyDetail?.email ?? ''}"),
                                                  )
                                                : const Text(
                                                    'Non renseigné',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
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
                                            child: (companyDetail?.phoneNumber
                                                        ?.isNotEmpty ==
                                                    true)
                                                ? Text(companyDetail
                                                        ?.phoneNumber ??
                                                    '')
                                                : const Text(
                                                    'Non renseigné',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              companyDetail?.description ?? '',
                                              textAlign: TextAlign.justify,
                                            ),
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Text("Liens",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                )),
                                            if (companyDetail
                                                    ?.links.isNotEmpty ==
                                                true)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                    companyDetail!.links.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    )),
                                              )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: (companyDetail
                                                    ?.links.isNotEmpty ==
                                                true)
                                            ? Column(children: [
                                                for (var link
                                                    in companyDetail?.links ??
                                                        [])
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                Row(children: [
                                                          const Icon(
                                                              Icons.link),
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
                                            : Row(
                                                children: const [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(Icons.link)),
                                                  Expanded(
                                                      child: Text(
                                                    'Aucun lien',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ))
                                                ],
                                              ),
                                      )
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
