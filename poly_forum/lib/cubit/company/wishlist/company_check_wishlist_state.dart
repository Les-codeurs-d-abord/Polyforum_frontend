part of 'company_check_wishlist_cubit.dart';

@immutable
abstract class CompanyCheckWishlistState {}

class CompanyCheckWishlistInitial extends CompanyCheckWishlistState {}

class CompanyCheckWishlistLoading extends CompanyCheckWishlistState {}

class CompanyCheckWishlistLoaded extends CompanyCheckWishlistState {
  final bool isInWishlist;
  CompanyCheckWishlistLoaded(this.isInWishlist);
}

class CompanyGetWishlistError extends CompanyCheckWishlistState {
  final String msg;
  CompanyGetWishlistError(this.msg);
}
