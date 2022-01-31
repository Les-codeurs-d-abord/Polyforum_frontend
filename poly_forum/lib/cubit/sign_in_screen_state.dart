part of 'sign_in_screen_cubit.dart';

@immutable
abstract class SignInScreenState {}

class SignInScreenInitial extends SignInScreenState {}

class SignInScreenLoading extends SignInScreenState {}

class SignInScreenLoaded extends SignInScreenState {
  final User user;

  SignInScreenLoaded(this.user);

  @override
  String toString() => "{ User: ${user.toString()} }";
}

class SignInScreenInvalidUserError extends SignInScreenState {
  final String message;
  SignInScreenInvalidUserError(this.message);
}

class SignInScreenError extends SignInScreenState {
  final String message;
  SignInScreenError(this.message);
}
