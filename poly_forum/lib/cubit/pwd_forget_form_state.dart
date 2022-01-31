part of 'pwd_forget_form_cubit.dart';

@immutable
abstract class PwdForgetFormState extends Equatable {
  const PwdForgetFormState();

  @override
  List<Object> get props => [];
}

class PwdForgetFormInitial extends PwdForgetFormState {}

class PwdForgetFormLoading extends PwdForgetFormState {}

class PwdForgetFormLoaded extends PwdForgetFormState {}

class PwdForgetFormError extends PwdForgetFormState {
  final String errorMessage;

  const PwdForgetFormError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
