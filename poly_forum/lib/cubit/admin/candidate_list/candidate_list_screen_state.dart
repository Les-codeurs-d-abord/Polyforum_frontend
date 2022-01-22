part of 'candidate_list_screen_cubit.dart';

@immutable
abstract class CandidateListScreenState extends Equatable {
  const CandidateListScreenState();

  @override
  List<Object> get props => [];
}

class CandidateListScreenInitial extends CandidateListScreenState {}

class CandidateListScreenLoading extends CandidateListScreenState {}

class CandidateListScreenLoaded extends CandidateListScreenState {
  final List<CandidateUser> candidateListInitial;
  final List<CandidateUser> candidateList;

  const CandidateListScreenLoaded(this.candidateListInitial, this.candidateList);

  @override
  List<Object> get props => [candidateListInitial, candidateList];
}

class CandidateListScreenError extends CandidateListScreenState {
  final String errorMessage;

  const CandidateListScreenError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CandidateListScreenErrorModal extends CandidateListScreenState {
  final String errorTitle;
  final String errorMessage;

  const CandidateListScreenErrorModal(this.errorTitle, this.errorMessage);

  @override
  List<Object> get props => [errorTitle, errorMessage];
}

class CandidateListScreenDelete extends CandidateListScreenState {
  final CandidateUser candidate;

  const CandidateListScreenDelete(this.candidate);

  @override
  List<Object> get props => [candidate];
}
