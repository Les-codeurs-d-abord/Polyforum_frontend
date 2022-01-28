import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_candidat_list_state.dart';

class CompanyCandidatListCubit extends Cubit<CompanyCandidatListState> {
  List<CandidateUser> candidateList = [];

  final CompanyRepository repository = CompanyRepository();

  CompanyCandidatListCubit() : super(CompanyCandidatListInitial());

  Future<void> getCandidateList() async {
    try {
      emit(CompanyCandidatListLoading());

      candidateList = await repository.getCandidateList();

      emit(CompanyCandidatListLoaded(candidateList));
    } on NetworkException catch (exception) {
      emit(CompanyCandidatListError(exception.message));
    }
  }

  Future<void> getCandidateListWithFilteringEvent(String filter) async {
    emit(CompanyCandidatListLoading());

    final offerListFiltered = candidateList.where((offer) {
      if (offer.lastName.toLowerCase().contains(filter.toLowerCase()) ||
          offer.firstName.toLowerCase().contains(filter.toLowerCase()) ||
          offer.description.toLowerCase().contains(filter.toLowerCase())) {
        return true;
      }
      for (String tag in offer.tags) {
        if (tag.toLowerCase().contains(filter.toLowerCase())) {
          return true;
        }
      }

      return false;
    }).toList();

    emit(CompanyCandidatListLoadedWithFilter(offerListFiltered));
  }
}
