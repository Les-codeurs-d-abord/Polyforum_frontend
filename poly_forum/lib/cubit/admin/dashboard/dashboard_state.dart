part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.companies, this.candidates);

  final List<Company> companies;
  final List<CandidateUser> candidates;

  @override
  List<List<dynamic>> get props => [companies, candidates];
}

class DashboardError extends DashboardState {
  final String errorMessage;

  const DashboardError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
