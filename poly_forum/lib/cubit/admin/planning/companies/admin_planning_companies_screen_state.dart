part of 'admin_planning_companies_screen_cubit.dart';

@immutable
abstract class AdminPlanningCompaniesState {}

class AdminPlanningCompaniesInitial extends AdminPlanningCompaniesState {}

class AdminPlanningCompaniesLoading extends AdminPlanningCompaniesState {}

class AdminPlanningCompaniesLoaded extends AdminPlanningCompaniesState {
  final List<Company> listCompanies;

  AdminPlanningCompaniesLoaded(this.listCompanies);
}

class AdminPlanningCompaniesAndPlanningLoaded
    extends AdminPlanningCompaniesState {
  final Planning planning;
  AdminPlanningCompaniesAndPlanningLoaded(this.planning);
}

class AdminPlanningCompaniesAddMeeting extends AdminPlanningCompaniesState {
  final List<CandidateMinimal> listCandidates;
  AdminPlanningCompaniesAddMeeting(this.listCandidates);
}

class AdminPlanningCompaniesError extends AdminPlanningCompaniesState {
  final String msg;

  AdminPlanningCompaniesError(this.msg);
}
