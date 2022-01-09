part of 'candidate_form_cubit.dart';

@immutable
abstract class CandidateFormState extends Equatable {
  const CandidateFormState();

  @override
  List<Object> get props => [];
}

class CandidateFormInitial extends CandidateFormState {}

class CandidateFormLoading extends CandidateFormState {}

class CandidateFormLoaded extends CandidateFormState {}

class CandidateFormError extends CandidateFormState {
  final String errorMessage;

  const CandidateFormError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
