import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/cubit/admin/company_list/company_offers_list_dialog_cubit.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/screens/shared/components/list/search_bar.dart';
import 'package:poly_forum/screens/shared/components/list/sort_button.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/modals/error_modal.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'company_card.dart';
import 'company_create_form_dialog.dart';
import 'company_detail_dialog.dart';
import 'company_edit_form_dialog.dart';
import 'company_offers_list_dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  List<Company> companyListInitial = [];
  List<Company> companyList = [];
  late Phase currentPhase;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        primary: false,
        child: SizedBox(
          height: 650,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //     "Entreprises",
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 40,
                            //     )
                            // ),
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
                                  const SizedBox(width: 60),
                                  const Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: SortButton(
                                        label: "Raison sociale",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CompanyListScreenCubit>(context).sortCompanyListByCompanyNameEvent(companyListInitial, companyList, ascending);
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: SortButton(
                                        label: "Nb d'offres",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CompanyListScreenCubit>(context).sortCompanyListByOffersCountEvent(companyListInitial, companyList, ascending);
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: SortButton(
                                        label: "Nb de voeux",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CompanyListScreenCubit>(context).sortCompanyListByWishesCountEvent(companyListInitial, companyList, ascending);
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
                                  } else if (state is CompanyListScreenErrorModal) {
                                    showTopSnackBar(
                                      context,
                                      Padding(
                                        padding: kTopSnackBarPadding,
                                        child: CustomSnackBar.error(
                                          message: state.errorMessage,
                                        ),
                                      ),
                                    );
                                  } else if (state is CompanyListScreenSuccessModal) {
                                    showTopSnackBar(
                                      context,
                                      Padding(
                                        padding: kTopSnackBarPadding,
                                        child: CustomSnackBar.success(
                                          message: state.successMessage,
                                        ),
                                      ),
                                    );
                                  } else if (state is CompanyListScreenDelete) {
                                    companyListInitial.remove(state.company);
                                    companyList.remove(state.company);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is CompanyListScreenLoading) {
                                    return buildLoadingScreen(context);
                                  } else if (state is CompanyListScreenLoaded || state is CompanyListScreenErrorModal
                                      || state is CompanyListScreenDelete || state is CompanyListScreenSuccessModal) {
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
                const VerticalDivider(
                  thickness: 1,
                  indent: 25,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 50, right: 50, top: 85, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    // color: Colors.grey[100],
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )
                                ),

                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          "Actions",
                                          overflow: TextOverflow.ellipsis,
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
                                          margin: const EdgeInsets.only(top: 20),
                                          child: MaterialButton(
                                            color: kBlue,
                                            disabledColor: kDisabledButtonColor,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(7))
                                            ),
                                            child: const Text(
                                              "Ajouter",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22
                                              ),
                                            ),
                                            onPressed: currentPhase != Phase.inscription ? null : () {
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
                                                if (value == ModalReturn.confirm) {
                                                  BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
                                                  BlocProvider.of<DashboardCubit>(context).fetchDashboardData();
                                                }
                                              });
                                            },
                                          )
                                      ),
                                      /* Bouton Rappels */
                                      Container(
                                          width: 300,
                                          height: 40,
                                          margin: const EdgeInsets.only(top: 10),
                                          child: MaterialButton(
                                            color: kDarkBlue,
                                            disabledColor: kDisabledButtonColor,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(7))
                                            ),
                                            child: const Text(
                                              "Rappels",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18
                                              ),
                                            ),
                                            onPressed: currentPhase == Phase.planning ? null : () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    if (currentPhase == Phase.inscription) {
                                                      return const ConfirmationModal(
                                                        title: "Envoi de rappels",
                                                        description: "Un mail de rappel va être envoyé à toutes les entreprises n'ayant pas complété leur profil ou n'ayant renseigné aucune offre.",
                                                      );
                                                    } else if (currentPhase == Phase.wish) {
                                                      return const ConfirmationModal(
                                                        title: "Envoi de rappels",
                                                        description: "Un mail de rappel va être envoyé à toutes les entreprises n'ayant fait aucun voeux.",
                                                      );
                                                    } else {
                                                      return const ErrorModal(
                                                        title: "Envoi de rappels",
                                                        description: "Aucun rappel à envoyer",
                                                      );
                                                    }
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
                            // Container(
                            //     height: 100,
                            //     width: double.infinity,
                            //     decoration: BoxDecoration(
                            //         borderRadius: const BorderRadius.all(Radius.circular(5)),
                            //         border: Border.all(
                            //           width: 1,
                            //           color: Colors.grey,
                            //         )
                            //     ),
                            //     margin: const EdgeInsets.only(top: 30),
                            //     padding: const EdgeInsets.all(10),
                            //     child: const Text("Chiffres clés")
                            // )
                          ],
                        )
                    )
                )
              ]
          ),
        )
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
        shrinkWrap: true,
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
              offersEvent: (company) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => CompanyOffersListDialogCubit(CompanyRepository()),
                        child: CompanyOffersListDialog(
                            currentPhase,
                            company
                        ),
                      );
                    },
                    barrierDismissible: false
                ).then((deleteCount) {
                  if (deleteCount > 0) {
                    BlocProvider.of<DashboardCubit>(context).fetchDashboardData();
                  }
                });
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
                  if (value == ModalReturn.confirm) {
                    BlocProvider.of<CompanyListScreenCubit>(context).fetchCompanyList();
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
                    BlocProvider.of<CompanyListScreenCubit>(context).deleteCompany(company).then((value) {
                      BlocProvider.of<DashboardCubit>(context).fetchDashboardData();
                    });
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
