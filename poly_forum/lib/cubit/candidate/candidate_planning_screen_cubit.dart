import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_planning_screen_state.dart';

class CandidatePlanningScreenCubit extends Cubit<CandidatePlanningScreenState> {
  final CandidateRepository repository = CandidateRepository();

  CandidatePlanningScreenCubit() : super(CandidatePlanningScreenInitial());

  Future<Planning?> planningEvent(CandidateUser user) async {
    try {
      emit(CandidatePlanningScreenLoading());

      final planning = await repository.fetchPlanning(user);

      emit(CandidatePlanningScreenLoaded(planning));
    } on NetworkException catch (exception) {
      emit(CandidatePlanningScreenError(exception.message));
    }
  }
}
