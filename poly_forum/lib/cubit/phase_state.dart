part of 'phase_cubit.dart';

@immutable
abstract class PhaseState {
  const PhaseState();

  @override
  List<Object> get props => [];
}

class PhaseInitial extends PhaseState {}

class PhaseLoading extends PhaseState {}

class PhaseLoaded extends PhaseState {}

class PhaseError extends PhaseState {
  final String errorMessage;

  const PhaseError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
