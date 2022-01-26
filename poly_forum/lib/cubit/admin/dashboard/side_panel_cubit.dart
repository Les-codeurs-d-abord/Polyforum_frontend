import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/phases_repository.dart';

part 'side_panel_state.dart';

class SidePanelCubit extends Cubit<SidePanelState> {
  final PhasesRepository _phasesRepository;

  SidePanelCubit(this._phasesRepository) : super(SidePanelInitial());

  Future<void> setWishPhase() async {
    try {
      emit(SidePanelButtonLoading());

      await _phasesRepository.setWishPhase();

      emit(SidePanelButtonLoaded());
    } on PhaseException catch (exception) {
      emit(SidePanelError(exception.message));
    } on Exception catch (_) {
      emit(const SidePanelError("Une erreur inconnue est survenue"));
    }
  }

  Future<void> setPlanningPhase() async {
    try {
      emit(SidePanelButtonLoading());

      await _phasesRepository.setPlanningPhase();

      emit(SidePanelButtonLoaded());
    } on PhaseException catch (exception) {
      emit(SidePanelError(exception.message));
    } on Exception catch (_) {
      emit(const SidePanelError("Une erreur inconnue est survenue"));
    }
  }

  Future<void> sendSatisfactionSurvey(String surveyLink) async {
    try {
      emit(SidePanelButtonLoading());

      await _phasesRepository.sendSatisfactionSurvey(surveyLink);

      emit(SidePanelButtonLoaded());
    } on PhaseException catch (exception) {
      emit(SidePanelError(exception.message));
    } on Exception catch (_) {
      emit(const SidePanelError("Une erreur inconnue est survenue"));
    }
  }
}
