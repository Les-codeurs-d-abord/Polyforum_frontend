import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/screens/shared/components/tags.dart';

part 'candidate_offer_screen_state.dart';

class CandidateOfferScreenCubit extends Cubit<CandidateOfferScreenState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateOfferScreenCubit() : super(CandidateOfferScreenInitial());

  Future<void> offerListEvent() async {
    try {
      emit(CandidateOfferScreenLoading());

      final offerList = await repository.fetchOfferList();

      emit(CandidateOfferScreenLoaded(offerList));
    } on NetworkException catch (exception) {
      emit(CandidateOfferScreenError(exception.message));
    }
  }

  Future<void> offerListWithFilteringEvent(
      List<Offer> offerList, String filter) async {
    emit(CandidateOfferScreenLoading());

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

    emit(CandidateOfferScreenLoadedWithFilter(offerListFiltered));
  }
}
