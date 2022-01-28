import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_get_wishlist_state.dart';

class CompanyGetWishlistCubit extends Cubit<CompanyGetWishlistState> {
  List<CompanyWish> wishlist = [];

  final CompanyRepository repository = CompanyRepository();

  CompanyGetWishlistCubit() : super(CompanyGetWishlistInitial());

  Future<void> getWishlist(CompanyUser company) async {
    try {
      emit(CompanyGetWishlistLoading());

      wishlist = await repository.getWishlist(company);

      emit(CompanyGetWishlistLoaded(wishlist));
    } on NetworkException catch (exception) {
      emit(CompanyGetWishlistError(exception.message));
    }
  }
}
