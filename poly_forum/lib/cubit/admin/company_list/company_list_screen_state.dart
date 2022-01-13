part of 'company_list_screen_cubit.dart';

@immutable
abstract class CompanyListScreenState extends Equatable {
  const CompanyListScreenState();

  @override
  List<Object> get props => [];
}

class CompanyListScreenInitial extends CompanyListScreenState {}

class CompanyListScreenLoading extends CompanyListScreenState {}

class CompanyListScreenLoaded extends CompanyListScreenState {
  final List<Company> companyListInitial;
  final List<Company> companyList;

  const CompanyListScreenLoaded(this.companyListInitial, this.companyList);

  @override
  List<Object> get props => [companyListInitial, companyList];
}

class CompanyListScreenError extends CompanyListScreenState {
  final String errorMessage;

  const CompanyListScreenError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

