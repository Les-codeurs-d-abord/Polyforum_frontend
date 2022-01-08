part of 'candidate_offer_screen_cubit.dart';

@immutable
abstract class CandidateOfferScreenState {}

class CandidateOfferScreenInitial extends CandidateOfferScreenState {}

class CandidateOfferScreenLoading extends CandidateOfferScreenState {}

class CandidateOfferScreenLoaded extends CandidateOfferScreenState {
  final List<Offer> offerList;

  CandidateOfferScreenLoaded(this.offerList);

  @override
  String toString() => "{ User: ${offerList.toString()} }";
}

class CandidateOfferScreenError extends CandidateOfferScreenState {
  final String msg;

  CandidateOfferScreenError(this.msg);
}
