part of 'update_candidate_cubit.dart';

@immutable
abstract class UpdateCandidateState {}

class UpdateCandidateInitial extends UpdateCandidateState {}

class UpdateCandidateLoading extends UpdateCandidateState {}

class UpdateCandidateLoaded extends UpdateCandidateState {
  final CandidateUser user;
  UpdateCandidateLoaded(this.user);
}

class UpdateCandidateError extends UpdateCandidateState {
  final String msg;
  UpdateCandidateError(this.msg);
}
