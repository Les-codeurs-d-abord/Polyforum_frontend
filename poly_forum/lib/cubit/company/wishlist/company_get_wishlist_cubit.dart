import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_get_wishlist_state.dart';

class CompanyGetWishlistCubit extends Cubit<CompanyGetWishlistState> {
  final CompanyRepository repository = CompanyRepository();

  CompanyGetWishlistCubit() : super(CompanyGetWishlistInitial());

  Future<void> getWishlist(CandidateUser user) async {
    try {
      emit(CompanyGetWishlistLoading());

      List<CompanyWish> wishlist = await repository.getWishlist(user);

      emit(CompanyGetWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CompanyGetWishlistError(exception.message));
    }
  }

  Future<void> inOfferInWishlist(
      CandidateUser candidate, CompanyUser company) async {
    try {
      emit(CompanyGetWishlistLoading());

      bool wishlist = await repository.isOfferInWishlist(company, candidate);

      emit(CompanyIsCandidateInWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CompanyGetWishlistError(exception.message));
    }
  }
}
