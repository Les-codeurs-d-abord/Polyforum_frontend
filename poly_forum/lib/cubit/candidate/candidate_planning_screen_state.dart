part of 'candidate_planning_screen_cubit.dart';

@immutable
abstract class CandidatePlanningScreenState {}

class CandidatePlanningScreenInitial extends CandidatePlanningScreenState {}

class CandidatePlanningScreenLoading extends CandidatePlanningScreenState {}

class CandidatePlanningScreenLoaded extends CandidatePlanningScreenState {
  final Planning planning;

  CandidatePlanningScreenLoaded(this.planning);

  @override
  String toString() => "{ Planning: $planning }";
}

class CandidatePlanningScreenError extends CandidatePlanningScreenState {
  final String msg;

  CandidatePlanningScreenError(this.msg);
}
