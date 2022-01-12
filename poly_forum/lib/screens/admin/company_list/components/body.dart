import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'company_card.dart';
import 'company_form_dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyListScreenCubit>(context).companyListEvent();
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
                            // TODO barre de recherche
                            const Text("Search bar"),
                            BlocConsumer<CompanyListScreenCubit, CompanyListScreenState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is CompanyListScreenLoading) {
                                    return buildLoadingScreen(context);
                                  } else if (state is CompanyListScreenLoaded) {
                                    return buildLoadedScreen(context, state.companyList);
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
                                                        child: const CompanyFormDialog(),
                                                      );
                                                    },
                                                    barrierDismissible: false
                                                );
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
    return const CircularProgressIndicator();
  }

  buildLoadedScreen(BuildContext context, List<Company> companyList) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(right: 12),
        primary: false,
        children: [
          for (var company in companyList) CompanyCard(company),
        ],
      ),
    );
  }

  buildInitialScreen(BuildContext context) {
    return const SizedBox();
  }
}
