import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_offer_state.dart';

class CompanyOfferCubit extends Cubit<CompanyOfferState> {
  Offer? offerToUpdate;

  final CompanyRepository repository = CompanyRepository();

  CompanyOfferCubit() : super(CompanyOfferInitial());

  Future<void> deleteOffer(Offer offer) async {
    try {
      emit(CompanyOfferLoading());

      await repository.deleteOffer(offer);

      emit(CompanyOfferLoaded(offer));
    } on NetworkException catch (exception) {
      emit(CompanyOfferError(exception.message));
    }
  }

  Future<void> createOffer(Offer offer) async {
    try {
      emit(CompanyOfferLoading());

      Offer offerResult = await repository.createOffer(offer);

      emit(CompanyOfferLoaded(offerResult));
    } on NetworkException catch (exception) {
      emit(CompanyOfferError(exception.message));
    }
  }

  Future<void> updateOffer(Offer offer) async {
    try {
      emit(CompanyOfferLoading());

      Offer offerResult = await repository.updateOffer(offer);

      emit(CompanyOfferLoaded(offerResult));
    } on NetworkException catch (exception) {
      emit(CompanyOfferError(exception.message));
    }
  }

  void setOfferToUpdate(Offer offer) {
    offerToUpdate = offer;
  }

  Offer? getOfferToUpdate() {
    return offerToUpdate;
  }
}
