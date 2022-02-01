part of 'info_phase_cubit.dart';

@immutable
abstract class InfoPhaseState {}

class InfoPhaseInitial extends InfoPhaseState {}

class InfoPhaseLoading extends InfoPhaseState {}

class InfoPhaseLoaded extends InfoPhaseState {
  final HashMap<int, List<Info>> infos;
  InfoPhaseLoaded(this.infos);
}

class InfoPhaseError extends InfoPhaseState {
  final String errorMessage;
  InfoPhaseError(this.errorMessage);
}
