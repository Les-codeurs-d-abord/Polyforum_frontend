import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/admin/planning/admin_fill_slot_modal_cubit.dart';
import 'package:poly_forum/cubit/admin/planning/admin_planning_candidates_screen_cubit.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FillSlotModal extends StatefulWidget {
  final String period;

  const FillSlotModal({Key? key, required this.period}) : super(key: key);

  @override
  State<FillSlotModal> createState() => _FillSlotModalState();
}

class _FillSlotModalState extends State<FillSlotModal> {
  List<CompanyMinimal>? listCompanies;
  CompanyMinimal? companySelected;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminFillSlotModalCubit>(context)
        .fetchFreeCompaniesRequestAtGivenPeriod(widget.period);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminFillSlotModalCubit, AdminFillSlotModalState>(
        listener: (context, state) {
      if (state is AdminFillSlotModalError) {
      } else if (state is AdminFillSlotModalLoaded) {
        listCompanies = state.listCompanies;
      }
    }, builder: (context, state) {
      if (state is AdminFillSlotModalError) {
        return buildloadingScreen();
      } else if (state is AdminFillSlotModalLoaded) {
        return buildLoadedScreen();
      }
      return buildInitialScreen();
    });
  }

  Widget buildloadingScreen() {
    return Container(
      color: Colors.cyan,
    );
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
              Navigator.of(context).pop(ModalReturn.cancel);
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
                Navigator.of(context).pop(ModalReturn.cancel);
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
                Navigator.of(context).pop(ModalReturn.confirm);
              },
            )),
      ],
    );
  }

  Widget buildInitialScreen() {
    return Container(
      color: Colors.blue,
    );
  }

  Widget listCompaniesInput() {
    return DropdownButton<CompanyMinimal>(
        // icon: const Icon(Icons.account_circle),
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
            child: Text(
              company.companyName,
              textAlign: TextAlign.center,
            ),
          );
        }).toList());
  }
}

enum ModalReturn { confirm, cancel }
