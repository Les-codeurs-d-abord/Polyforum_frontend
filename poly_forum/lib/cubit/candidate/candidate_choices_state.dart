part of 'candidate_choices_cubit.dart';

@immutable
abstract class CandidateChoicesState {}

class CandidateChoicesInitial extends CandidateChoicesState {}

class CandidateChoicesScreenLoading extends CandidateChoicesState {}

class CandidateChoicesScreenLoaded extends CandidateChoicesState {
  final List<Wish> offerList;

  CandidateChoicesScreenLoaded(this.offerList);
}

class CandidateChoicesScreenError extends CandidateChoicesState {
  final String msg;

  CandidateChoicesScreenError(this.msg);
}
