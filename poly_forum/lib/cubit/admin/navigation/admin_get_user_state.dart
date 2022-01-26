part of 'admin_get_user_cubit.dart';

abstract class AdminGetUserState {}

class AdminGetUserInitial extends AdminGetUserState {}

class AdminGetUserLoading extends AdminGetUserState {}

class AdminGetUserLoaded extends AdminGetUserState {}

class AdminGetUserError extends AdminGetUserState {
  final String msg;
  AdminGetUserError(this.msg);
}
