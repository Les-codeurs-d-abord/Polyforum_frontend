part of 'company_form_cubit.dart';

@immutable
abstract class CompanyFormState extends Equatable {
  const CompanyFormState();

  @override
  List<Object> get props => [];
}

class CompanyFormInitial extends CompanyFormState {}

class CompanyFormLoading extends CompanyFormState {}

class CompanyFormLoaded extends CompanyFormState {}

class CompanyFormError extends CompanyFormState {
  final String errorMessage;

  const CompanyFormError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
