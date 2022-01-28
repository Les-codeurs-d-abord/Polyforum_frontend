import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_check_wishlist_state.dart';

class CompanyCheckWishlistCubit extends Cubit<CompanyCheckWishlistState> {
  List<CompanyWish> wishlist = [];

  final CompanyRepository repository = CompanyRepository();

  CompanyCheckWishlistCubit() : super(CompanyCheckWishlistInitial());

  Future<void> inOfferInWishlist(
      CandidateUser candidate, CompanyUser company) async {
    try {
      emit(CompanyCheckWishlistLoading());

      bool wishlist = await repository.isOfferInWishlist(company, candidate);

      emit(CompanyCheckWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CompanyGetWishlistError(exception.message));
    }
  }
}
