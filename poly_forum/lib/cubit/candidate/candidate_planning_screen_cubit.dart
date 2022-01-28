import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/planning_repository.dart';

part 'candidate_planning_screen_state.dart';

class CandidatePlanningScreenCubit extends Cubit<CandidatePlanningScreenState> {
  final PlanningRepository repository = PlanningRepository();

  CandidatePlanningScreenCubit() : super(CandidatePlanningScreenInitial());

  Future<Planning?> planningEvent(CandidateUser user) async {
    try {
      emit(CandidatePlanningScreenLoading());

      final planning = await repository.fetchPlanningWithUserId(user.id);

      emit(CandidatePlanningScreenLoaded(planning));
    } on NetworkException catch (exception) {
      emit(CandidatePlanningScreenError(exception.message));
    }
  }
}
