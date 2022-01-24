part of 'candidate_wishlist_cubit.dart';

@immutable
abstract class CandidateWishlistState {}

class CandidateWishlistInitial extends CandidateWishlistState {}

class CandidateWishlistLoading extends CandidateWishlistState {}

class CandidateWishlistLoaded extends CandidateWishlistState {}

class CandidateWishlistError extends CandidateWishlistState {
  final String msg;

  CandidateWishlistError(this.msg);
}
