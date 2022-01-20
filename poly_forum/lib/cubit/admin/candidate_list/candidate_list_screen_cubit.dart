import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'candidate_list_screen_state.dart';

class CandidateListScreenCubit extends Cubit<CandidateListScreenState> {
  final CandidateRepository _candidateRepository;

  CandidateListScreenCubit(this._candidateRepository) : super(CandidateListScreenInitial());

  Future<void> fetchCandidateList() async {
    try {
      emit(CandidateListScreenLoading());

      final candidateListInitial = await _candidateRepository.fetchCandidateList();
      final candidateList = candidateListInitial;
      candidateListInitial.sort((a, b) => a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase()));

      emit(CandidateListScreenLoaded(candidateListInitial, candidateList));
    } on CandidateException catch (exception) {
      emit(CandidateListScreenError(exception.message));
    } on NetworkException catch (exception) {
      emit(CandidateListScreenError(exception.message));
    }
  }

  Future<void> deleteCandidate(CandidateUser candidate) async {
    emit(CandidateListScreenLoading());

    try {
      await _candidateRepository.deleteCandidate(candidate);

      emit(CandidateListScreenDelete(candidate));
    } on CandidateException catch (exception) {
      emit(CandidateListScreenErrorModal("Suppression d'un candidat", exception.message));
    } on NetworkException catch (exception) {
      emit(CandidateListScreenErrorModal("Suppression d'un candidat", exception.message));
    }
  }

  Future<void> sendReminder() async {
    emit(CandidateListScreenLoading());

    try {
      await _candidateRepository.sendReminder();
    } on NetworkException catch (exception) {
      emit(CandidateListScreenErrorModal("Envoi d'un rappel", exception.message));
    }
  }

  Future<void> filterCandidateList(List<CandidateUser> candidateListInitial, List<CandidateUser> candidateList, String filter) async {
    emit(CandidateListScreenLoading());

    candidateList = candidateListInitial.where((candidate) {
      return (candidate.lastName.toLowerCase() + " " + candidate.firstName.toLowerCase()).contains(filter.toLowerCase()) ||
          (candidate.firstName.toLowerCase() + " " + candidate.lastName.toLowerCase()).contains(filter.toLowerCase());
    }).toList();

    emit(CandidateListScreenLoaded(candidateListInitial, candidateList));
  }

  Future<void> sortCandidateListByNameEvent(List<CandidateUser> candidateListInitial, List<CandidateUser> candidateList, bool ascending) async {
    emit(CandidateListScreenLoading());

    candidateListInitial.sort((a, b) {
      return ascending ?
      a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase()) :
      b.lastName.toLowerCase().compareTo(a.lastName.toLowerCase());
    });
    candidateList.sort((a, b) {
      return ascending ?
      a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase()) :
      b.lastName.toLowerCase().compareTo(a.lastName.toLowerCase());
    });

    emit(CandidateListScreenLoaded(candidateListInitial, candidateList));
  }

  Future<void> sortCandidateListByCompletionEvent(List<CandidateUser> candidateListInitial, List<CandidateUser> candidateList, bool ascending) async {
    // TODO
  }

}
