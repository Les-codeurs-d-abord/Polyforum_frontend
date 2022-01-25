import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_choices_save_state.dart';

class CandidateChoicesSaveCubit extends Cubit<CandidateChoicesSaveState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateChoicesSaveCubit() : super(CandidateChoicesSaveInitial());

  Future<void> saveOfferChoicesEvent(
      CandidateUser user, List<Wish> wishlist) async {
    try {
      emit(CandidateChoicesSaveLoading());

      await repository.saveChoicesOffer(user, wishlist);

      emit(CandidateChoicesSaveLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateOfferSaveError(exception.message));
    }
  }
}
