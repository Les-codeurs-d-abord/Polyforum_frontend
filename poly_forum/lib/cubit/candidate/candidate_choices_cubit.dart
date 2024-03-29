import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_choices_state.dart';

class CandidateChoicesCubit extends Cubit<CandidateChoicesState> {
  final CandidateRepository repository = CandidateRepository();

  CandidateChoicesCubit() : super(CandidateChoicesInitial());

  Future<void> offerChoicesListEvent(CandidateUser user) async {
    try {
      emit(CandidateChoicesScreenLoading());

      final List<Wish> offerList = await repository.getWishlist(user);

      emit(CandidateChoicesScreenLoaded(offerList));
    } on NetworkException catch (exception) {
      emit(CandidateChoicesScreenError(exception.message));
    }
  }
}
