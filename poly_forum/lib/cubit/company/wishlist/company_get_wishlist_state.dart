part of 'company_get_wishlist_cubit.dart';

@immutable
abstract class CompanyGetWishlistState {}

class CompanyGetWishlistInitial extends CompanyGetWishlistState {}

class CompanyGetWishlistLoading extends CompanyGetWishlistState {}

class CompanyGetWishlistLoaded extends CompanyGetWishlistState {
  final List<CompanyWish> wishlist;
  CompanyGetWishlistLoaded(this.wishlist);
}

class CompanyIsCandidateInWishlistLoaded extends CompanyGetWishlistState {
  final bool isInWishlist;
  CompanyIsCandidateInWishlistLoaded(this.isInWishlist);
}

class CompanyGetWishlistError extends CompanyGetWishlistState {
  final String msg;
  CompanyGetWishlistError(this.msg);
}
