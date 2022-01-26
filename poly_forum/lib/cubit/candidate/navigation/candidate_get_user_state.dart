part of 'candidate_get_user_cubit.dart';

@immutable
abstract class CandidateGetUserState {}

class CandidateGetUserInitial extends CandidateGetUserState {}

class CandidateGetUserLoading extends CandidateGetUserState {}

class CandidateGetUserLoaded extends CandidateGetUserState {}

class CandidateGetUserError extends CandidateGetUserState {
  final String msg;
  CandidateGetUserError(this.msg);
}
