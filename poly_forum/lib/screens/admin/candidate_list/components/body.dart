import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_list_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/shared/components/form/form_return_enum.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/utils/constants.dart';

import 'candidate_create_form_dialog.dart';

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
                  child: Container(),
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
}
