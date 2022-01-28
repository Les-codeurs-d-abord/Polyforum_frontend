part of 'company_wishlist_cubit.dart';

@immutable
abstract class CompanyWishlistState {}

class CompanyWishlistInitial extends CompanyWishlistState {}

class CompanyWishlistLoading extends CompanyWishlistState {}

class CompanyWishlistLoaded extends CompanyWishlistState {}

class CompanyWishlistError extends CompanyWishlistState {
  final String msg;
  CompanyWishlistError(this.msg);
}
