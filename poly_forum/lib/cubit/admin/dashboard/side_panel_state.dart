part of 'side_panel_cubit.dart';

abstract class SidePanelState extends Equatable {
  const SidePanelState();

  @override
  List<Object> get props => [];
}

class SidePanelInitial extends SidePanelState {}

class SidePanelButtonLoading extends SidePanelState {}

class SidePanelButtonLoaded extends SidePanelState {}

class SidePanelError extends SidePanelState {
  final String errorMessage;

  const SidePanelError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
