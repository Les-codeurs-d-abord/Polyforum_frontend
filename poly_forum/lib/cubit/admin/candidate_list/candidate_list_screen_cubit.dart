import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_list_screen_state.dart';

class CandidateListScreenCubit extends Cubit<CandidateListScreenState> {
  final CandidateRepository _candidateRepository;

  CandidateListScreenCubit(this._candidateRepository) : super(CandidateListScreenInitial());

  Future<List<CandidateUser>> fetchCandidateList() async {
    // TODO
    return [];
  }

  Future<void> sendReminder() async {
    // TODO
  }
}
