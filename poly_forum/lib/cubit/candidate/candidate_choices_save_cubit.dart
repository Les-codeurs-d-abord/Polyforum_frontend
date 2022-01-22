import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_choices_save_state.dart';

class CandidateChoicesSaveCubit extends Cubit<CandidateChoicesSaveState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateChoicesSaveCubit() : super(CandidateChoicesSaveInitial());

  Future<void> saveOfferChoicesEvent(List<Offer> offerList) async {
    try {
      emit(CandidateChoicesSaveLoading());

      await repository.saveChoicesOffer(offerList);

      emit(CandidateChoicesSaveLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateOfferSaveError(exception.message));
    }
  }
}
