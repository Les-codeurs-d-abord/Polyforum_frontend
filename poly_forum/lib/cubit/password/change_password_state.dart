part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
