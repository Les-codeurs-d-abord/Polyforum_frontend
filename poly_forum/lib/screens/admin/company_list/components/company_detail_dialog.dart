import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/company_list/company_form_cubit.dart';
import 'package:poly_forum/data/models/company_detail_model.dart';

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
    BlocProvider.of<CompanyFormCubit>(context).getCompanyDetail(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyFormCubit, CompanyFormState>(
        listener: (context, state) {
          if (state is CompanyDetailLoaded) {
            companyDetail = state.company;
          }
        },
        builder: (context, state) {
          if (state is CompanyFormLoading) {
            return buildCompanyDetailDialog(context, isLoading: true);
          } else if (state is CompanyDetailLoaded) {
            return buildCompanyDetailDialog(context, companyDetail: companyDetail);
          } else if (state is CompanyFormError) {
            return buildCompanyDetailDialog(context, error: state.errorMessage);
          } else {
            return buildCompanyDetailDialog(context);
          }
        }
    );
  }

  buildCompanyDetailDialog(BuildContext context, {CompanyDetail? companyDetail, bool isLoading = false, String error = ''}) {
    return AlertDialog(
      title: Stack(
          children: [
            Text(
              "Détail de l'entreprise ${companyDetail?.companyName}",
              style: const TextStyle(
                  fontSize: 22
              ),
            ),
            Positioned(
              right: 0,
              child: InkResponse(
                radius: 20,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),
          ]
      ),
      content: const SizedBox(
          width: 400,
          child: Text("TODO")
      ),
    );
  }
}
