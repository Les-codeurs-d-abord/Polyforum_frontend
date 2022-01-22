part of 'candidate_choices_cubit.dart';

@immutable
abstract class CandidateChoicesState {}

class CandidateChoicesInitial extends CandidateChoicesState {}

class CandidateChoicesScreenLoading extends CandidateChoicesState {}

class CandidateChoicesScreenLoaded extends CandidateChoicesState {
  final List<Offer> offerList;

  CandidateChoicesScreenLoaded(this.offerList);
}

class CandidateOfferScreenError extends CandidateChoicesState {
  final String msg;

  CandidateOfferScreenError(this.msg);
}
