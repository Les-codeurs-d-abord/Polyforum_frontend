part of 'candidate_offer_screen_cubit.dart';

@immutable
abstract class CandidateOfferScreenState {}

class CandidateOfferScreenInitial extends CandidateOfferScreenState {}

class CandidateOfferScreenLoading extends CandidateOfferScreenState {}

class CandidateOfferScreenLoaded extends CandidateOfferScreenState {
  final List<Offer> offerList;

  CandidateOfferScreenLoaded(this.offerList);
}

class CandidateOfferScreenLoadedWithFilter extends CandidateOfferScreenState {
  final List<Offer> offerList;
  CandidateOfferScreenLoadedWithFilter(this.offerList);
}

class CandidateOfferScreenError extends CandidateOfferScreenState {
  final String msg;

  CandidateOfferScreenError(this.msg);
}
