import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/phases_repository.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';

part 'phase_state.dart';

class PhaseCubit extends Cubit<PhaseState> {
  final PhasesRepository _phasesRepository;
  Phase currentPhase = Phase.inscription;

  PhaseCubit(this._phasesRepository) : super(PhaseInitial());

  Future<void> fetchCurrentPhase() async {
    try {
      emit(PhaseLoading());

      currentPhase = await _phasesRepository.fetchCurrentPhase();

      emit(PhaseLoaded());
    } on PhaseException catch (exception) {
      emit(PhaseError(exception.message));
    } on Exception catch (_) {
      emit(PhaseError("Une erreur inconnue est survenue"));
    }
  }

  Phase getCurrentPhase() {
    return currentPhase;
  }
}
