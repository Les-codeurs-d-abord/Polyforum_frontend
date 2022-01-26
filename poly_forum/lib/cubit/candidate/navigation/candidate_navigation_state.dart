part of 'candidate_navigation_cubit.dart';

@immutable
abstract class CandidateNavigationState {}

class CandidateNavigationLoaded extends CandidateNavigationState {
  final int index;
  CandidateNavigationLoaded(this.index);
}
