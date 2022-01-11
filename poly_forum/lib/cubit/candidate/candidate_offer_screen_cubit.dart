import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_offer_screen_state.dart';

class CandidateOfferScreenCubit extends Cubit<CandidateOfferScreenState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateOfferScreenCubit() : super(CandidateOfferScreenInitial());

  Future<void> offerListEvent(Tag? tag, String? input) async {
    try {
      emit(CandidateOfferScreenLoading());

      final offerList = await repository.fetchOfferList(tag, input);

      emit(CandidateOfferScreenLoaded(offerList));
    } on NetworkException catch (exception) {
      emit(CandidateOfferScreenError(exception.message));
    }
  }
}
