import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is DashboardLoading) {
          return LayoutBuilder(builder: (context, constraints) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: const Text("Tableau de bord",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ))))
                  ]),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]);
          });
        } else if (state is DashboardError) {
          return LayoutBuilder(builder: (context, constraints) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: const Text("Tableau de bord",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ))))
                  ]),
                  Center(child: Text(state.errorMessage)),
                  Container(
                      width: 200,
                      height: 50,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: kOrange,
                      ),
                      child: MaterialButton(
                        onPressed: () => {},
                        child: const Text(
                          "Clôturer la saisie",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ))
                ]);
          });
        } else if (state is DashboardLoaded) {
          final List<Company> companyList = state.companies;
          final List<Candidate> candidateList = state.candidates;
          final List<Offer> offerList = state.offers;
          
          return LayoutBuilder(builder: (context, constraints) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: const Text("Tableau de bord",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ))))
                  ]),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 50,
                          ),
                          child: ResponsiveGridRow(
                            children: [
                              // INDICATEUR NB ENTREPRISES
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(companyList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Entreprises")
                                          ],
                                        )),
                                  )),
                              ),
                              // INDICATEUR NB CANDIDATS
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(candidateList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Candidats")
                                          ],
                                        )),
                                  )),
                              // INDICATEUR NB OFFRES
                              ),
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(offerList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Offres")
                                          ],
                                        )),
                                  )),
                              // INDICATEUR 4
                              ),
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(companyList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Entreprises ont complété leur profil",
                                            style: TextStyle(
                                              
                                            ),)
                                          ],
                                        )),
                                  )),
                              // INDICATEUR 5
                              ),
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child :Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(companyList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Candidats ont complété leur profil")
                                          ],
                                        )),
                                  )),
                              // INDICATEUR 6
                              ),
                              ResponsiveGridCol(
                                xs: 6,
                                md: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 50,
                                          horizontal: 50,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(companyList.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Text("Entreprises")
                                          ],
                                        )),
                                  ))
                              )
                            ],
                          ))),
                  Container(
                      width: 200,
                      height: 50,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: kOrange,
                      ),
                      child: MaterialButton(
                        onPressed: () => {},
                        child: const Text(
                          "Clôturer la saisie",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ))
                ]);
          });
        } else {
          return Container();
        }
      },
    );
  }

  buildDashboardScreen(BuildContext context) {}
}
