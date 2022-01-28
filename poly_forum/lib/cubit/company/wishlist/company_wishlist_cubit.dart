import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_wishlist_state.dart';

class CompanyWishlistCubit extends Cubit<CompanyWishlistState> {
  final CompanyRepository repository = CompanyRepository();

  CompanyWishlistCubit() : super(CompanyWishlistInitial());

  Future<void> addWish(CompanyUser company, CandidateUser candidate) async {
    try {
      emit(CompanyWishlistLoading());

      await repository.createWish(company, candidate);

      emit(CompanyWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyWishlistError(exception.message));
    }
  }

  Future<void> removeWish(CompanyUser company, CandidateUser candidate) async {
    try {
      emit(CompanyWishlistLoading());

      await repository.deleteWish(company, candidate);

      emit(CompanyWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyWishlistError(exception.message));
    }
  }

  Future<void> updateWishlist(
      CompanyUser company, List<CompanyWish> wishlist) async {
    try {
      emit(CompanyWishlistLoading());

      await repository.updateWishlist(company, wishlist);

      emit(CompanyWishlistLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyWishlistError(exception.message));
    }
  }
}
