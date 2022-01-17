import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/shared/components/form/form_return_enum.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/list/search_bar.dart';
import 'package:poly_forum/screens/shared/components/list/sort_button.dart';
import 'package:poly_forum/screens/shared/components/modals/error_modal.dart';
import 'package:poly_forum/utils/constants.dart';

import 'company_card.dart';
import 'company_create_form_dialog.dart';
import 'company_detail_dialog.dart';
import 'company_edit_form_dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  List<Company> companyListInitial = [];
  List<Company> companyList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "Entreprises",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              width: 500,
                              child: SearchBar(
                                searchCallback: (search) {
                                  BlocProvider.of<CompanyListScreenCubit>(context).filterCompanyList(companyListInitial, companyList, search);
                                }
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 50),
                                  const Spacer(),
                                  Expanded(
                                    child: SortButton(
                                        label: "Raison sociale",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CompanyListScreenCubit>(context).sortCompanyListByCompanyNameEvent(companyListInitial, companyList, ascending);
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: SortButton(
                                        label: "Nombre d'offres",
                                        sortCallback: (ascending) {
                                          // TODO
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  const SizedBox(width: 50),
                                ],
                              ),
                            ),
                            BlocConsumer<CompanyListScreenCubit, CompanyListScreenState>(
                                listener: (context, state) {
                                  if (state is CompanyListScreenLoaded) {
                                    companyListInitial = state.companyListInitial;
                                    companyList = state.companyList;
                                  }
                                  if (state is CompanyListScreenErrorModal) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ErrorModal(
                                              title: state.errorTitle,
                                              description: state.errorMessage
                                          );
                                        },
                                        barrierDismissible: true
                                    );
                                  }
                                  if (state is CompanyListScreenDelete) {
                                    companyListInitial.remove(state.company);
                                    companyList.remove(state.company);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is CompanyListScreenLoading) {
                                    return buildLoadingScreen(context);
                                  } else if (state is CompanyListScreenLoaded || state is CompanyListScreenErrorModal
                                      || state is CompanyListScreenDelete) {
                                    return buildLoadedScreen(context, companyList);
                                  } else if (state is CompanyListScreenError) {
                                    return buildErrorScreen(context, state.errorMessage);
                                  } else {
                                    return buildInitialScreen(context);
                                  }
                                }
                            )
                          ],
                        )
                    )
                ),
                SizedBox(
                    width: 425,
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 50, right: 50, top: 30, bottom: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey[200],
                                  ),
                                  child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Actions",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        /* Bouton Ajouter */
                                        Container(
                                            width: 300,
                                            height: 60,
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20, top: 20),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                              color: kOrange,
                                            ),
                                            child: MaterialButton(
                                              child: const Text(
                                                "Ajouter",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return BlocProvider(
                                                        create: (context) => CompanyFormCubit(CompanyRepository()),
                                                        child: const CompanyCreateFormDialog(),
                                                      );
                                                    },
                                                    barrierDismissible: false
                                                ).then((value) {
                                                  if (value == FormReturn.confirm) {
                                                    BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
                                                  }
                                                });
                                              },
                                            )
                                        ),
                                        /* Bouton extraire */
                                        Container(
                                            width: 300,
                                            height: 40,
                                            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(7)),
                                              color: kBlue,
                                            ),
                                            child: MaterialButton(
                                              padding: const EdgeInsets.all(10),
                                              child: const Text(
                                                "Extraire",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18
                                                ),
                                              ),
                                              onPressed: () {

                                              },
                                            )
                                        ),
                                        /* Bouton Rappel */
                                        Container(
                                            width: 300,
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20, top: 10),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                              color: kBlue,
                                            ),
                                            child: MaterialButton(
                                              child: const Text(
                                                "Rappel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return const ConfirmationModal(
                                                        title: "Envoi d'un rappel",
                                                        description: "Un mail de rappel va être envoyé à toutes les entreprises n'ayant pas complété leur profil ou n'ayant renseigné aucune offre.",
                                                      );
                                                    },
                                                    barrierDismissible: false
                                                ).then((value) {
                                                  if (value == ModalReturn.confirm) {
                                                    BlocProvider.of<CompanyListScreenCubit>(context).sendReminder();
                                                  }
                                                });
                                              },
                                            )
                                        )
                                      ]
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey[200],
                                  ),
                                  margin: const EdgeInsets.only(top: 30),
                                  padding: const EdgeInsets.all(10),
                                  child: const Text("Chiffres clés")
                              ),
                            )
                          ],
                        )
                    )
                )
              ]
          );
        }
    );
  }

  buildLoadingScreen(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

  buildLoadedScreen(BuildContext context, List<Company> companyList) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(right: 12),
        primary: false,
        children: [
          for (var company in companyList) CompanyCard(
              company: company,
              detailEvent: (company) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => CompanyFormCubit(CompanyRepository()),
                        child: CompanyDetailDialog(company.id),
                      );
                    },
                    barrierDismissible: false
                );
              },
              editEvent: (company) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => CompanyFormCubit(CompanyRepository()),
                        child: CompanyEditFormDialog(company),
                      );
                    },
                    barrierDismissible: false
                ).then((value) {
                  if (value == FormReturn.confirm) {
                    // BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
                  }
                });
              },
              deleteEvent: (company) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationModal(
                      title: "Suppression d'une entreprise",
                      description: "Vous-êtes sur le point de supprimer l'entreprise ${company.companyName}, en êtes-vous sûr ?",
                    );
                  },
                ).then((value) {
                  if (value == ModalReturn.confirm) {
                    BlocProvider.of<CompanyListScreenCubit>(context).deleteCompany(company);
                  }
                });
              }
          ),
        ],
      ),
    );
  }

  buildErrorScreen(BuildContext context, String errorMessage) {
    return Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.red
      ),
    );
  }

  buildInitialScreen(BuildContext context) {
    return const SizedBox();
  }
}
