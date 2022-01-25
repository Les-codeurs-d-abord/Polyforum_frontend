import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_wishlist_state.dart';

class CandidateWishlistCubit extends Cubit<CandidateWishlistState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateWishlistCubit() : super(CandidateWishlistInitial());

  Future<void> addWish(Offer offer, CandidateUser user) async {
    try {
      emit(CandidateWishlistLoading());

      await repository.createWish(offer, user);

      emit(CandidateWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateWishlistError(exception.message));
    }
  }

  Future<void> removeWish(Offer offer, CandidateUser user) async {
    try {
      emit(CandidateWishlistLoading());

      await repository.deleteWish(offer, user);

      emit(CandidateWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateWishlistError(exception.message));
    }
  }
}
