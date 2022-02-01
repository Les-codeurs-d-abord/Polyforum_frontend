import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_list_screen_cubit.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/shared/components/modals/modal_return_enum.dart';
import 'package:poly_forum/screens/shared/components/list/search_bar.dart';
import 'package:poly_forum/screens/shared/components/list/sort_button.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/modals/error_modal.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/screens/shared/components/shimmer_loading.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

  late final Phase currentPhase;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateListScreenCubit>(context).fetchCandidateList();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        primary: false,
        child: SizedBox(
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
                        //     "Candidats",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 40,
                        //     )
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: 500,
                          child: SearchBar(searchCallback: (search) {
                            BlocProvider.of<CandidateListScreenCubit>(context)
                                .filterCandidateList(candidateListInitial,
                                    candidateList, search);
                          }),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 55),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: SortButton(
                                    label: "Nom prénom",
                                    sortCallback: (ascending) {
                                      BlocProvider.of<CandidateListScreenCubit>(
                                              context)
                                          .sortCandidateListByNameEvent(
                                              candidateListInitial,
                                              candidateList,
                                              ascending);
                                    }),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: SortButton(
                                    label: "Complétion",
                                    sortCallback: (ascending) {
                                      BlocProvider.of<CandidateListScreenCubit>(
                                              context)
                                          .sortCandidateListByCompletionEvent(
                                              candidateListInitial,
                                              candidateList,
                                              ascending);
                                    }),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: SortButton(
                                    label: "Nb de voeux",
                                    sortCallback: (ascending) {
                                      BlocProvider.of<CandidateListScreenCubit>(
                                              context)
                                          .sortCandidateListByWishesCountEvent(
                                              candidateListInitial,
                                              candidateList,
                                              ascending);
                                    }),
                              ),
                              const Spacer(),
                              const SizedBox(width: 55),
                            ],
                          ),
                        ),
                        BlocConsumer<CandidateListScreenCubit,
                                CandidateListScreenState>(
                            listener: (context, state) {
                          if (state is CandidateListScreenLoaded) {
                            candidateListInitial = state.candidateListInitial;
                            candidateList = state.candidateList;
                          } else if (state is CandidateListScreenErrorModal) {
                            showTopSnackBar(
                              context,
                              Padding(
                                padding: kTopSnackBarPadding,
                                child: CustomSnackBar.error(
                                  message: state.errorMessage,
                                ),
                              ),
                            );
                          } else if (state is CandidateListScreenSuccessModal) {
                            showTopSnackBar(
                              context,
                              Padding(
                                padding: kTopSnackBarPadding,
                                child: CustomSnackBar.success(
                                  message: state.successMessage,
                                ),
                              ),
                            );
                          } else if (state is CandidateListScreenDelete) {
                            candidateListInitial.remove(state.candidate);
                            candidateList.remove(state.candidate);
                          }
                        }, builder: (context, state) {
                          if (state is CandidateListScreenLoading) {
                            return buildLoadingScreen(context);
                          } else if (state is CandidateListScreenLoaded ||
                              state is CandidateListScreenErrorModal ||
                              state is CandidateListScreenDelete ||
                              state is CandidateListScreenSuccessModal) {
                            return buildLoadedScreen(context, candidateList);
                          } else if (state is CandidateListScreenError) {
                            return buildErrorScreen(
                                context, state.errorMessage);
                          } else {
                            return buildInitialScreen(context);
                          }
                        })
                      ],
                    ))),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                // color: Colors.grey[100],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                )),
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
                                          fontWeight: FontWeight.bold),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7))),
                                        child: const Text(
                                          "Ajouter",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                        onPressed: currentPhase !=
                                                Phase.inscription
                                            ? null
                                            : () {
                                                showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return BlocProvider(
                                                            create: (context) =>
                                                                CandidateFormCubit(
                                                                    CandidateRepository()),
                                                            child:
                                                                const CandidateCreateFormDialog(),
                                                          );
                                                        },
                                                        barrierDismissible:
                                                            false)
                                                    .then((value) {
                                                  if (value ==
                                                      ModalReturn.confirm) {
                                                    BlocProvider.of<
                                                                CandidateListScreenCubit>(
                                                            context)
                                                        .fetchCandidateList();
                                                    BlocProvider.of<
                                                                DashboardCubit>(
                                                            context)
                                                        .fetchDashboardData();
                                                  }
                                                });
                                              },
                                      )),
                                  /* Bouton Rappels */
                                  Container(
                                      width: 300,
                                      height: 40,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: MaterialButton(
                                        color: kDarkBlue,
                                        disabledColor: kDisabledButtonColor,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7))),
                                        child: const Text(
                                          "Rappels",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        onPressed: currentPhase ==
                                                Phase.planning
                                            ? null
                                            : () {
                                                showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          if (currentPhase ==
                                                              Phase
                                                                  .inscription) {
                                                            return const ConfirmationModal(
                                                              title:
                                                                  "Envoi de rappels",
                                                              description:
                                                                  "Un mail de rappel va être envoyé à tous les candidats n'ayant pas complété leur profil.",
                                                            );
                                                          } else if (currentPhase ==
                                                              Phase.wish) {
                                                            return const ConfirmationModal(
                                                              title:
                                                                  "Envoi de rappels",
                                                              description:
                                                                  "Un mail de rappel va être envoyé à tous les candidats n'ayant fait aucun voeux.",
                                                            );
                                                          } else {
                                                            return const ErrorModal(
                                                              title:
                                                                  "Envoi de rappels",
                                                              description:
                                                                  "Aucun rappel à envoyer",
                                                            );
                                                          }
                                                        },
                                                        barrierDismissible:
                                                            false)
                                                    .then((value) {
                                                  if (value ==
                                                      ModalReturn.confirm) {
                                                    BlocProvider.of<
                                                                CandidateListScreenCubit>(
                                                            context)
                                                        .sendReminder();
                                                  }
                                                });
                                              },
                                      ))
                                ])),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text("Légende",
                                      style: TextStyle(
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Row(children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 15,
                                  ),
                                  Flexible(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Profil complet",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                                ]),
                                Row(children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.orange,
                                    size: 15,
                                  ),
                                  Flexible(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Profil incomplet",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                                ]),
                                Row(children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                  Flexible(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Jamais connecté",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                                ]),
                              ],
                            ))
                      ],
                    )))
          ],
        )));
  }

  buildLoadingScreen(BuildContext context) {
    return const ShimmerLoading(nbBlock: 1, nbLine: 10);
  }

  buildLoadedScreen(BuildContext context, List<CandidateUser> candidateList) {
    return Column(
      children: [
        for (var candidate in candidateList)
          CandidateCard(
              candidate: candidate,
              detailEvent: (candidate) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) =>
                            CandidateFormCubit(CandidateRepository()),
                        child: CandidateDetailDialog(candidate.id),
                      );
                    },
                    barrierDismissible: false);
              },
              editEvent: (candidate) {
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) =>
                                CandidateFormCubit(CandidateRepository()),
                            child: CandidateEditFormDialog(candidate),
                          );
                        },
                        barrierDismissible: false)
                    .then((value) {
                  if (value == ModalReturn.confirm) {
                    BlocProvider.of<CandidateListScreenCubit>(context)
                        .fetchCandidateList();
                  }
                });
              },
              deleteEvent: (candidate) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationModal(
                      title: "Suppression d'un candidat",
                      description:
                          "Vous-êtes sur le point de supprimer le candidat ${candidate.firstName} ${candidate.lastName}, en êtes-vous sûr ?",
                    );
                  },
                ).then((value) {
                  if (value == ModalReturn.confirm) {
                    BlocProvider.of<CandidateListScreenCubit>(context)
                        .deleteCandidate(candidate)
                        .then((value) {
                      BlocProvider.of<DashboardCubit>(context)
                          .fetchDashboardData();
                    });
                  }
                });
              }),
      ],
    );
  }

  buildErrorScreen(BuildContext context, String errorMessage) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }

  buildInitialScreen(BuildContext context) {
    return const SizedBox();
  }
}
