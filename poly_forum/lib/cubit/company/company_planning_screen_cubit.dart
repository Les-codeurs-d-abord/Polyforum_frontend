import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/planning_repository.dart';

part 'company_planning_screen_state.dart';

class CompanyPlanningScreenCubit extends Cubit<CompanyPlanningScreenState> {
  final PlanningRepository repository = PlanningRepository();

  CompanyPlanningScreenCubit() : super(CompanyPlanningScreenInitial());

  Future<Planning?> planningEvent(CompanyUser user) async {
    try {
      emit(CompanyPlanningScreenLoading());

      final planning = await repository.fetchPlanningWithUserId(user.id);

      emit(CompanyPlanningScreenLoaded(planning));
    } on NetworkException catch (exception) {
      emit(CompanyPlanningScreenError(exception.message));
    }
  }
}
