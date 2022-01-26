part of 'phase_cubit.dart';

@immutable
abstract class PhaseState {}

class PhaseInitial extends PhaseState {}

class PhaseLoading extends PhaseState {}

class PhaseLoaded extends PhaseState {}

class PhaseError extends PhaseState {
  final String errorMessage;

  PhaseError(this.errorMessage);
}
