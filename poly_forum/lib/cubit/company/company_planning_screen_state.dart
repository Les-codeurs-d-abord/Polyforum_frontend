part of 'company_planning_screen_cubit.dart';

@immutable
abstract class CompanyPlanningScreenState {}

class CompanyPlanningScreenInitial extends CompanyPlanningScreenState {}

class CompanyPlanningScreenLoading extends CompanyPlanningScreenState {}

class CompanyPlanningScreenLoaded extends CompanyPlanningScreenState {
  final Planning planning;

  CompanyPlanningScreenLoaded(this.planning);

  @override
  String toString() => "{ Planning: $planning }";
}

class CompanyPlanningScreenError extends CompanyPlanningScreenState {
  final String msg;

  CompanyPlanningScreenError(this.msg);
}
