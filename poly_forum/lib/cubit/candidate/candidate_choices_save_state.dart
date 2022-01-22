part of 'candidate_choices_save_cubit.dart';

@immutable
abstract class CandidateChoicesSaveState {}

class CandidateChoicesSaveInitial extends CandidateChoicesSaveState {}

class CandidateChoicesSaveLoading extends CandidateChoicesSaveState {}

class CandidateChoicesSaveLoaded extends CandidateChoicesSaveState {}

class CandidateOfferSaveError extends CandidateChoicesSaveState {
  final String msg;

  CandidateOfferSaveError(this.msg);
}
