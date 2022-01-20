import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_list_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/shared/components/form/form_return_enum.dart';
import 'package:poly_forum/screens/shared/components/list/search_bar.dart';
import 'package:poly_forum/screens/shared/components/list/sort_button.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/modals/error_modal.dart';
import 'package:poly_forum/utils/constants.dart';

import 'candidate_card.dart';
import 'candidate_create_form_dialog.dart';
import 'candidate_detail_dialog.dart';
import 'candidate_edit_form_dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<CandidateUser> candidateListInitial = [];
  List<CandidateUser> candidateList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateListScreenCubit>(context).fetchCandidateList();
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
                            const Text(
                                "Candidats",
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
                                    BlocProvider.of<CandidateListScreenCubit>(context).filterCandidateList(candidateListInitial, candidateList, search);
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
                                        label: "Nom prénom",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CandidateListScreenCubit>(context).sortCandidateListByNameEvent(candidateListInitial, candidateList, ascending);
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: SortButton(
                                        label: "Complétion",
                                        sortCallback: (ascending) {
                                          BlocProvider.of<CandidateListScreenCubit>(context).sortCandidateListByCompletionEvent(candidateListInitial, candidateList, ascending);
                                        }
                                    ),
                                  ),
                                  const Spacer(),
                                  const SizedBox(width: 50),
                                ],
                              ),
                            ),
                            BlocConsumer<CandidateListScreenCubit, CandidateListScreenState>(
                                listener: (context, state) {
                                  if (state is CandidateListScreenLoaded) {
                                    candidateListInitial = state.candidateListInitial;
                                    candidateList = state.candidateList;
                                  }
                                  if (state is CandidateListScreenErrorModal) {
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
                                  if (state is CandidateListScreenDelete) {
                                    candidateListInitial.remove(state.candidate);
                                    candidateList.remove(state.candidate);
                                  }
                                },
                                builder: (context, state) {
                                  if (state is CandidateListScreenLoading) {
                                    return buildLoadingScreen(context);
                                  } else if (state is CandidateListScreenLoaded || state is CandidateListScreenErrorModal
                                      || state is CandidateListScreenDelete) {
                                    return buildLoadedScreen(context, candidateList);
                                  } else if (state is CandidateListScreenError) {
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
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(7)),
                                            color: kBlue,
                                          ),
                                          child: MaterialButton(
                                            child: const Text(
                                              "Ajouter",
                                              overflow: TextOverflow.ellipsis,
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
                                                      create: (context) => CandidateFormCubit(CandidateRepository()),
                                                      child: const CandidateCreateFormDialog(),
                                                    );
                                                  },
                                                  barrierDismissible: false
                                              ).then((value) {
                                                if (value == FormReturn.confirm) {
                                                  BlocProvider.of<CandidateListScreenCubit>(context).fetchCandidateList();
                                                }
                                              });
                                            },
                                          )
                                      ),
                                      /* Bouton extraire */
                                      Container(
                                          width: 300,
                                          height: 40,
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(7)),
                                            color: kDarkBlue,
                                          ),
                                          child: MaterialButton(
                                            padding: const EdgeInsets.all(10),
                                            child: const Text(
                                              "Extraire",
                                              overflow: TextOverflow.ellipsis,
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
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                            color: kDarkBlue,
                                          ),
                                          child: MaterialButton(
                                            child: const Text(
                                              "Rappel",
                                              overflow: TextOverflow.ellipsis,
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
                                                      description: "Un mail de rappel va être envoyé à tous les candidats n'ayant pas complété leur profil.",
                                                    );
                                                  },
                                                  barrierDismissible: false
                                              ).then((value) {
                                                if (value == ModalReturn.confirm) {
                                                  BlocProvider.of<CandidateListScreenCubit>(context).sendReminder();
                                                }
                                              });
                                            },
                                          )
                                      )
                                    ]
                                )
                            ),
                            Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    )
                                ),
                                margin: const EdgeInsets.only(top: 30),
                                padding: const EdgeInsets.all(10),
                                child: const Text("Chiffres clés")
                            )
                          ],
                        )
                    )
                )
              ],
            )
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

  buildLoadedScreen(BuildContext context, List<CandidateUser> candidateList) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(right: 12),
        primary: false,
        shrinkWrap: true,
        children: [
          for (var candidate in candidateList) CandidateCard(
              candidate: candidate,
              detailEvent: (candidate) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => CandidateFormCubit(CandidateRepository()),
                        child: CandidateDetailDialog(candidate.id),
                      );
                    },
                    barrierDismissible: false
                );
              },
              editEvent: (candidate) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => CandidateFormCubit(CandidateRepository()),
                        child: CandidateEditFormDialog(candidate),
                      );
                    },
                    barrierDismissible: false
                ).then((value) {
                  if (value == FormReturn.confirm) {
                    BlocProvider.of<CandidateListScreenCubit>(context).fetchCandidateList();
                  }
                });
              },
              deleteEvent: (candidate) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationModal(
                      title: "Suppression d'un candidat",
                      description: "Vous-êtes sur le point de supprimer le candidat ${candidate.firstName} ${candidate.lastName}, en êtes-vous sûr ?",
                    );
                  },
                ).then((value) {
                  if (value == ModalReturn.confirm) {
                    BlocProvider.of<CandidateListScreenCubit>(context).deleteCandidate(candidate);
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
