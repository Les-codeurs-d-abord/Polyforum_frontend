part of 'company_navigation_cubit.dart';

@immutable
abstract class CompanyNavigationState {}

class CompanyNavigationLoaded extends CompanyNavigationState {
  final int index;
  CompanyNavigationLoaded(this.index);
}
