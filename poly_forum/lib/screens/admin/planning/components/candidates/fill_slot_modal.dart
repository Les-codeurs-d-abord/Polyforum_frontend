import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/candidates/admin_fill_slot_modal_candidate_cubit.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillSlotModal extends StatefulWidget {
  final String period;
  final int userId;

  const FillSlotModal({Key? key, required this.period, required this.userId})
      : super(key: key);

  @override
  State<FillSlotModal> createState() => _FillSlotModalState();
}

class _FillSlotModalState extends State<FillSlotModal> {
  List<CompanyMinimal>? listCompanies;
  CompanyMinimal? companySelected;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminFillSlotModalCubit>(context)
        .fetchFreeCompaniesRequestAtGivenPeriod(widget.period, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminFillSlotModalCubit, AdminFillSlotModalState>(
        listener: (context, state) {
      if (state is AdminFillSlotModalError) {
      } else if (state is AdminFillSlotModalLoaded) {
        listCompanies = state.listCompanies;
      } else if (state is AdminFillSlotModalLoadedCreation) {
        Navigator.of(context).pop(ModalSlotReturn.confirm);
      }
    }, builder: (context, state) {
      if (state is AdminFillSlotModalLoading) {
        return Container();
      } else if (state is AdminFillSlotModalLoadingCreation) {
        return buildCandidateFormDialog(context, true);
      } else if (state is AdminFillSlotModalLoadedCreation) {
        return buildCandidateFormDialog(context, true);
      } else if (state is AdminFillSlotModalError) {
        return buildCandidateFormDialog(context, false, state.msg);
      } else {
        return buildCandidateFormDialog(context);
      }
    });
  }

  Widget buildLoadedScreen() {
    return AlertDialog(
      title: Stack(children: [
        const Text(
          "Ajouter un rendez-vous avec une entreprise",
          style: TextStyle(fontSize: 22),
        ),
        Positioned(
          right: 0,
          child: InkResponse(
            radius: 20,
            onTap: () {
              Navigator.of(context).pop(ModalSlotReturn.cancel);
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ),
      ]),
      content: SizedBox(child: listCompaniesInput()),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      actions: [
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            child: MaterialButton(
              child: const Text(
                "Annuler",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop(ModalSlotReturn.cancel);
              },
            )),
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: kButtonColor,
            ),
            child: MaterialButton(
              child: const Text(
                "Confirmer",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                BlocProvider.of<AdminFillSlotModalCubit>(context).createMeeting(
                    companySelected!.userId, widget.userId, widget.period);
              },
            )),
      ],
    );
  }

  Widget listCompaniesInput() {
    return DropdownButton<CompanyMinimal>(
        dropdownColor: Colors.grey[300],
        hint: const Text("Choisir une entreprise"),
        icon: const Icon(Icons.business),
        style: const TextStyle(color: Colors.black),
        isExpanded: true,
        value: companySelected,
        onChanged: (CompanyMinimal? newValue) {
          setState(() {
            companySelected = newValue!;
          });
        },
        items: listCompanies!
            .map<DropdownMenuItem<CompanyMinimal>>((CompanyMinimal company) {
          return DropdownMenuItem<CompanyMinimal>(
            value: company,
            child: Text(company.companyName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black)),
          );
        }).toList());
  }

  Widget buildCandidateFormDialog(BuildContext context,
      [bool isLoading = false, String error = '']) {
    return AlertDialog(
      title: Stack(children: [
        const Text(
          "Ajouter un rendez-vous avec une entreprise",
          style: TextStyle(fontSize: 22),
        ),
        Positioned(
          right: 0,
          child: InkResponse(
            radius: 20,
            onTap: () {
              isLoading
                  ? null
                  : Navigator.of(context).pop(ModalSlotReturn.cancel);
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ),
      ]),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 450,
          child: Wrap(
            children: [
              listCompaniesInput(),
              if (error.isNotEmpty)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      actions: [
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey,
            ),
            child: MaterialButton(
              child: const Text(
                "Annuler",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                isLoading
                    ? null
                    : Navigator.of(context).pop(ModalSlotReturn.cancel);
              },
            )),
        Container(
            width: 200,
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: kButtonColor,
            ),
            child: MaterialButton(
              child: isLoading
                  ? const SizedBox(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                      width: 15,
                      height: 15,
                    )
                  : const Text(
                      "Valider",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate() &&
                          companySelected != null) {
                        _formKey.currentState!.save();
                        BlocProvider.of<AdminFillSlotModalCubit>(context)
                            .createMeeting(widget.userId,
                                companySelected!.userId, widget.period);
                      }
                    },
            )),
      ],
    );
  }
}

enum ModalSlotReturn { confirm, cancel }
