import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'admin_planning_candidates_screen_state.dart';

class AdminPlanningCandidatesCubit extends Cubit<AdminPlanningCandidatesState> {
  final CandidateRepository repository = CandidateRepository();

  AdminPlanningCandidatesCubit() : super(AdminPlanningCandidatesInitial());

  Future<List<Candidate>?> fetchAllCandidates() async {
    try {
      emit(AdminPlanningCandidatesLoading());

      final candidatesList = await repository.getCandidates();

      emit(AdminPlanningCandidatesLoaded(candidatesList));
    } on NetworkException catch (exception) {
      emit(AdminPlanningCandidatesError(exception.message));
    }
  }

  Future<Planning?> fetchPlanningForGivenCandidate(Candidate candidate) async {
    try {
      emit(AdminPlanningCandidatesLoading());

      final planning =
          await repository.fetchPlanningWithUserId(candidate.userId);

      emit(AdminPlanningCandidatesAndPlanningLoaded(planning));
    } on NetworkException catch (exception) {
      emit(AdminPlanningCandidatesError(exception.message));
    }
  }
}
