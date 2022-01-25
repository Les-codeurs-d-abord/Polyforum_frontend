import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_detail_model.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
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

  Future<void> editCandidate(CandidateUser candidate, String newEmail) async {
    try {
      emit(CandidateFormLoading());

      await _candidateRepository.editCandidate(candidate, newEmail);

      emit(CandidateFormLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on CandidateException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on Exception catch (_) {
      emit(const CandidateFormError("Une erreur inconnue est survenue"));
    }
  }

  Future<void> getCandidateDetail(int id) async {
    try {
      emit(CandidateFormLoading());

      CandidateDetail candidate = await _candidateRepository.getCandidateDetail(id);

      emit(CandidateDetailLoaded(candidate));
    } on NetworkException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on CandidateException catch (exception) {
      emit(CandidateFormError(exception.message));
    } on Exception catch (_) {
      emit(const CandidateFormError("Une erreur inconnue est survenue"));
    }
  }

}
