import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_minimal_model.dart';
import 'package:poly_forum/resources/planning_repository.dart';

part 'admin_fill_slot_modal_company_state.dart';

class AdminFillSlotModalCubit extends Cubit<AdminFillSlotModalState> {
  final PlanningRepository repository = PlanningRepository();

  AdminFillSlotModalCubit() : super(AdminFillSlotModalInitial());

  Future<List<CandidateMinimal>?> fetchFreeCandidatesRequestAtGivenPeriod(
      period, userId) async {
    try {
      emit(AdminFillSlotModalLoading());

      final listCandidates = await repository
          .fetchFreeCandidatesRequestAtGivenPeriod(period, userId);

      emit(AdminFillSlotModalLoaded(listCandidates));
    } on NetworkException catch (exception) {
      emit(AdminFillSlotModalError(exception.message));
    }
  }

  Future<void> createMeeting(userIdCandidate, userIdCompany, period) async {
    try {
      emit(AdminFillSlotModalLoadingCreation());

      await repository.createMeeting(userIdCandidate, userIdCompany, period);

      emit(AdminFillSlotModalLoadedCreation());
    } on NetworkException catch (exception) {
      emit(AdminFillSlotModalError(exception.message));
    } on PlanningException catch (exception) {
      emit(AdminFillSlotModalError(exception.message));
    } on Exception catch (_) {
      emit(AdminFillSlotModalError("Une erreur inconnue est survenue"));
    }
  }
}
