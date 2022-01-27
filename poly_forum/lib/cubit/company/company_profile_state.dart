part of 'company_profile_cubit.dart';

@immutable
abstract class CompanyProfileState {}

class CompanyProfileInitial extends CompanyProfileState {}

class CompanyProfileLoading extends CompanyProfileState {}

class CompanyProfileLoaded extends CompanyProfileState {}

class CompanyProfileError extends CompanyProfileState {
  final String msg;
  CompanyProfileError(this.msg);
}
