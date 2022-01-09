import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_form_state.dart';

class CandidateFormCubit extends Cubit<CandidateFormState> {

  final CandidateRepository _candidateRepository;

  CandidateFormCubit(this._candidateRepository) : super(CandidateFormInitial());

  Future<void> createCandidate(String email, String lastName, String firstName) async {
    try {
      emit(CandidateFormLoading());

      await _candidateRepository.createCandidate(email, lastName, firstName);

      emit(CandidateFormLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on CandidateException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on Exception catch (_) {
      emit(const CandidateFormError("Une erreur inconnue est survenue"));
    }
  }

}
