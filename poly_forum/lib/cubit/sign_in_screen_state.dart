part of 'sign_in_screen_cubit.dart';

@immutable
abstract class SignInScreenState extends Equatable {
  const SignInScreenState();

  @override
  List<Object> get props => [];
}

class SignInScreenInitial extends SignInScreenState {}

class SignInScreenLoading extends SignInScreenState {}

class SignInScreenLoaded extends SignInScreenState {
  final User user;

  const SignInScreenLoaded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => "{ User: ${user.toString()} }";
}

class SignInScreenInvalidUserError extends SignInScreenState {
  final String message;
  const SignInScreenInvalidUserError(this.message);

  @override
  List<Object> get props => [message];
}

class SignInScreenError extends SignInScreenState {
  final String message;
  const SignInScreenError(this.message);

  @override
  List<Object> get props => [message];
}
