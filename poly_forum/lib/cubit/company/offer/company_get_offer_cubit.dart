import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_get_offer_state.dart';

class CompanyGetOfferCubit extends Cubit<CompanyGetOfferState> {
  List<Offer> offerList = [];

  final CompanyRepository repository = CompanyRepository();

  CompanyGetOfferCubit() : super(CompanyGetOfferInitial());

  Future<void> getOfferList(CompanyUser company) async {
    try {
      emit(CompanyGetOfferLoading());

      offerList = await repository.fetchOffersFromCompany(company.id);

      emit(CompanyGetOfferLoaded(offerList));
    } on NetworkException catch (exception) {
      emit(CompanyGetOfferError(exception.message));
    } on CompanyException catch (exception) {
      emit(CompanyGetOfferError(exception.message));
    }
  }

  Future<void> offerListWithFilteringEvent(String filter) async {
    emit(CompanyGetOfferLoading());

    final offerListFiltered = offerList.where((offer) {
      if (offer.companyName.toLowerCase().contains(filter.toLowerCase()) ||
          offer.name.toLowerCase().contains(filter.toLowerCase()) ||
          offer.description.toLowerCase().contains(filter.toLowerCase())) {
        return true;
      }
      for (String tag in offer.tags) {
        if (tag.toLowerCase().contains(filter.toLowerCase())) {
          return true;
        }
      }

      return false;
    }).toList();

    emit(CompanyGetOfferLoadedWithFilter(offerListFiltered));
  }

  void deleteLocalOffer(Offer offer) {
    emit(CompanyGetOfferLoading());
    offerList.remove(offer);
    emit(CompanyGetOfferLoaded(offerList));
  }
}
