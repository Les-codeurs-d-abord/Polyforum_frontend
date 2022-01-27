part of 'company_candidat_list_cubit.dart';

@immutable
abstract class CompanyCandidatListState {}

class CompanyCandidatListInitial extends CompanyCandidatListState {}

class CompanyCandidatListLoading extends CompanyCandidatListState {}

class CompanyCandidatListLoaded extends CompanyCandidatListState {
  final List<CandidateUser> candidateList;
  CompanyCandidatListLoaded(this.candidateList);
}

class CompanyCandidatListLoadedWithFilter extends CompanyCandidatListState {
  final List<CandidateUser> candidateList;
  CompanyCandidatListLoadedWithFilter(this.candidateList);
}

class CompanyCandidatListError extends CompanyCandidatListState {
  final String msg;
  CompanyCandidatListError(this.msg);
}
