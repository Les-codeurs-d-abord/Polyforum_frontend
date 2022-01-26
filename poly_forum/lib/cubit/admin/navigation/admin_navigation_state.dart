part of 'admin_navigation_cubit.dart';

@immutable
abstract class AdminNavigationState {}

class AdminNavigationLoaded extends AdminNavigationState {
  final int index;
  AdminNavigationLoaded(this.index);
}

class AdminNavigationInitial extends AdminNavigationState {}
