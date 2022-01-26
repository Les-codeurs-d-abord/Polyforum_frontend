import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/planning_repository.dart' as pr;

part 'admin_planning_candidates_screen_state.dart';

class AdminPlanningCandidatesCubit extends Cubit<AdminPlanningCandidatesState> {
  final CandidateRepository candidateRepository = CandidateRepository();
  final pr.PlanningRepository planningRepository = pr.PlanningRepository();

  AdminPlanningCandidatesCubit() : super(AdminPlanningCandidatesInitial());

  Future<List<Candidate>?> fetchAllCandidates() async {
    try {
      emit(AdminPlanningCandidatesLoading());

      final candidatesList = await candidateRepository.getCandidates();

      emit(AdminPlanningCandidatesLoaded(candidatesList));
    } on NetworkException catch (exception) {
      emit(AdminPlanningCandidatesError(exception.message));
    }
  }

  Future<Planning?> fetchPlanningForGivenCandidate(userId) async {
    try {
      emit(AdminPlanningCandidatesLoading());

      final planning = await planningRepository.fetchPlanningWithUserId(userId);

      emit(AdminPlanningCandidatesAndPlanningLoaded(planning));
    } on pr.NetworkException catch (exception) {
      emit(AdminPlanningCandidatesError(exception.message));
    }
  }

  Future<void> removeMeeting(userIdCandidate, userIdCompany, period) async {
    try {
      emit(AdminPlanningCandidatesLoading());

      await planningRepository.deleteMeeting(
          userIdCandidate, userIdCompany, period);

      fetchPlanningForGivenCandidate(userIdCandidate);
    } on pr.NetworkException catch (exception) {
      emit(AdminPlanningCandidatesError(exception.message));
    }
  }
}
