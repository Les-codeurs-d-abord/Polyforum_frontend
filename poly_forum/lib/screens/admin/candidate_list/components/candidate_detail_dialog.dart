import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_form_cubit.dart';
import 'package:poly_forum/data/models/candidate_detail_model.dart';

class CandidateDetailDialog extends StatefulWidget {
  final int candidateId;

  const CandidateDetailDialog(this.candidateId, {Key? key}) : super(key: key);

  @override
  _CandidateDetailDialogState createState() => _CandidateDetailDialogState();
}

class _CandidateDetailDialogState extends State<CandidateDetailDialog> {
  CandidateDetail? candidateDetail;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidateFormCubit>(context).getCandidateDetail(widget.candidateId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateFormCubit, CandidateFormState>(
        listener: (context, state) {
          if (state is CandidateDetailLoaded) {
            candidateDetail = state.candidate;
          }
        },
        builder: (context, state) {
          if (state is CandidateFormLoading) {
            return buildCandidateDetailDialog(context, isLoading: true);
          } else if (state is CandidateDetailLoaded) {
            return buildCandidateDetailDialog(context, candidateDetail: candidateDetail);
          } else if (state is CandidateFormError) {
            return buildCandidateDetailDialog(context, error: state.errorMessage);
          } else {
            return buildCandidateDetailDialog(context);
          }
        }
    );
  }

  buildCandidateDetailDialog(BuildContext context, {CandidateDetail? candidateDetail, bool isLoading = false, String error = ''}) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Détail du candidat ${candidateDetail?.lastName} ${candidateDetail?.firstName}",
              style: const TextStyle(
                  fontSize: 22
              ),
            ),
          ),
          InkResponse(
            radius: 20,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
      content: const SizedBox(
        width: 900,
        height: 500,
      ),
    );
  }
}
