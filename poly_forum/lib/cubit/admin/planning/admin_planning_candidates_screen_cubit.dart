import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'admin_planning_candidates_screen_state.dart';

class AdminPlanningCandidatesCubit extends Cubit<AdminPlanningCandidatesState> {
  final CandidateRepository repository = CandidateRepository();

  AdminPlanningCandidatesCubit() : super(AdminPlanningCandidatesInitial());

  // Future<void> candidatesEvent() async {
  //   try {
  //     emit(CandidateOfferScreenLoading());

  //     final offerList = await repository.fetchOfferList(tag, input);

  //     emit(CandidateOfferScreenLoaded(offerList));
  //   } on NetworkException catch (exception) {
  //     emit(CandidateOfferScreenError(exception.message));
  //   }
  // }
}
