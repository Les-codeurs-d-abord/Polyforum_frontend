part of 'welcome_screen_cubit.dart';

@immutable
abstract class WelcomeScreenState extends Equatable {
  const WelcomeScreenState();

  @override
  List<Object> get props => [];
}

class WelcomeScreenInitial extends WelcomeScreenState {}

class WelcomeScreenLoading extends WelcomeScreenState {}

class WelcomeScreenLoaded extends WelcomeScreenState {
  final User user;

  const WelcomeScreenLoaded(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => "{ User: ${user.toString()} }";
}

class WelcomeScreenError extends WelcomeScreenState {
  final String message;

  const WelcomeScreenError(this.message);

  @override
  List<Object> get props => [message];
}

class WelcomeScreenUserUnfound extends WelcomeScreenState {}
