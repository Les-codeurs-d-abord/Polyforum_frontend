part of 'admin_planning_candidates_screen_cubit.dart';

@immutable
abstract class AdminPlanningCandidatesState {}

class AdminPlanningCandidatesInitial extends AdminPlanningCandidatesState {}

class AdminPlanningCandidatesLoading extends AdminPlanningCandidatesState {}

class AdminPlanningCandidatesLoaded extends AdminPlanningCandidatesState {
  final List<Candidate> listCandidates;

  AdminPlanningCandidatesLoaded(this.listCandidates);
}

class AdminPlanningCandidatesAndPlanningLoaded
    extends AdminPlanningCandidatesState {
  final Planning planning;
  AdminPlanningCandidatesAndPlanningLoaded(this.planning);
}

class AdminPlanningCandidatesError extends AdminPlanningCandidatesState {
  final String msg;

  AdminPlanningCandidatesError(this.msg);
}
