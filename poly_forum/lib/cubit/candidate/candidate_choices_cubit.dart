import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'candidate_choices_state.dart';

class CandidateChoicesCubit extends Cubit<CandidateChoicesState> {
  final CandidateChoicesCubit repository = CandidateChoicesCubit();

  CandidateChoicesCubit() : super(CandidateOfferScreenInitial());

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
