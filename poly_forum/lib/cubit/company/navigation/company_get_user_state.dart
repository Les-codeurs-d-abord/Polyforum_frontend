part of 'company_get_user_cubit.dart';

@immutable
abstract class CompanyGetUserState {}

class CompanyGetUserInitial extends CompanyGetUserState {}

class CompanyGetUserLoading extends CompanyGetUserState {}

class CompanyGetUserLoaded extends CompanyGetUserState {}

class CompanyGetUserError extends CompanyGetUserState {
  final String msg;
  CompanyGetUserError(this.msg);
}
