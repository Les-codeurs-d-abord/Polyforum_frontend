part of 'candidate_get_wishlist_cubit.dart';

@immutable
abstract class CandidateGetWishlistState {}

class CandidateGetWishlistInitial extends CandidateGetWishlistState {}

class CandidateGetWishlistLoading extends CandidateGetWishlistState {}

class CandidateGetWishlistLoaded extends CandidateGetWishlistState {
  final List<Wish> wishlist;
  CandidateGetWishlistLoaded(this.wishlist);
}

class CandidateIsOfferInWishlistLoaded extends CandidateGetWishlistState {
  final bool isInWishlist;
  CandidateIsOfferInWishlistLoaded(this.isInWishlist);
}

class CandidateGetWishlistError extends CandidateGetWishlistState {
  final String msg;
  CandidateGetWishlistError(this.msg);
}
