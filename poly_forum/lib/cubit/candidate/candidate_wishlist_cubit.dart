import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_wishlist_state.dart';

class CandidateWishlistCubit extends Cubit<CandidateWishlistState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateWishlistCubit() : super(CandidateWishlistInitial());

  Future<void> addWishlist(Offer offer, CandidateUser user) async {
    try {
      emit(CandidateWishlistInitial());

      await repository.fetchOfferList();

      emit(CandidateWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateWishlistError(exception.message));
    }
  }
}
