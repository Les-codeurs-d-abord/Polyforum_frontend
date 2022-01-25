import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_get_wishlist_state.dart';

class CandidateGetWishlistCubit extends Cubit<CandidateGetWishlistState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateGetWishlistCubit() : super(CandidateGetWishlistInitial());

  Future<void> getWishlist(CandidateUser user) async {
    try {
      emit(CandidateGetWishlistLoading());

      List<Wish> wishlist = await repository.getWishlist(user);

      emit(CandidateGetWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CandidateGetWishlistError(exception.message));
    }
  }

  Future<void> inOfferInWishlist(CandidateUser user, Offer offer) async {
    try {
      emit(CandidateGetWishlistLoading());

      bool wishlist = await repository.isOfferInWishlist(offer, user);

      emit(CandidateIsOfferInWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CandidateGetWishlistError(exception.message));
    }
  }
}
