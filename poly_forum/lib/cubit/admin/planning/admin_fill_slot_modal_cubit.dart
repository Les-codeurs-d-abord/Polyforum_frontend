import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'admin_fill_slot_modal_state.dart';

class AdminFillSlotModalCubit extends Cubit<AdminFillSlotModalState> {
  final CandidateRepository repository = CandidateRepository();

  AdminFillSlotModalCubit() : super(AdminFillSlotModalInitial());

  Future<List<CompanyMinimal>?> fetchFreeCompaniesRequestAtGivenPeriod(
      period) async {
    try {
      emit(AdminFillSlotModalLoading());

      final listCompanies =
          await repository.fetchFreeCompaniesRequestAtGivenPeriod(period);

      emit(AdminFillSlotModalLoaded(listCompanies));
    } on NetworkException catch (exception) {
      emit(AdminFillSlotModalError(exception.message));
    }
  }
}
