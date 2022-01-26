import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_list_screen_state.dart';

class CompanyListScreenCubit extends Cubit<CompanyListScreenState> {
  final CompanyRepository _companyRepository;

  CompanyListScreenCubit(this._companyRepository) : super(CompanyListScreenInitial());

  Future<void> fetchCompanyList() async {
    try {
      emit(CompanyListScreenLoading());

      final companyListInitial = await _companyRepository.fetchCompanyList();
      final companyList = companyListInitial;
      companyListInitial.sort((a, b) => a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()));

      emit(CompanyListScreenLoaded(companyListInitial, companyList));
    } on CompanyException catch (exception) {
      emit(CompanyListScreenError(exception.message));
    } on NetworkException catch (exception) {
      emit(CompanyListScreenError(exception.message));
    }
  }

  Future<void> sortCompanyListByCompanyNameEvent(List<Company> companyListInitial, List<Company> companyList, bool ascending) async {
    emit(CompanyListScreenLoading());

    companyListInitial.sort((a, b) {
      return ascending ?
      a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()) :
      b.companyName.toLowerCase().compareTo(a.companyName.toLowerCase());
    });
    companyList.sort((a, b) {
      return ascending ?
      a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()) :
      b.companyName.toLowerCase().compareTo(a.companyName.toLowerCase());
    });

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }

  Future<void> sortCompanyListByOffersCountEvent(List<Company> companyListInitial, List<Company> companyList, bool ascending) async {
    emit(CompanyListScreenLoading());

    companyListInitial.sort((a, b) {
      return ascending ?
      a.offersCount.compareTo(b.offersCount) :
      b.offersCount.compareTo(a.offersCount);
    });
    companyList.sort((a, b) {
      return ascending ?
      a.offersCount.compareTo(b.offersCount) :
      b.offersCount.compareTo(a.offersCount);
    });

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }

  Future<void> sortCompanyListByWishesCountEvent(List<Company> companyListInitial, List<Company> companyList, bool ascending) async {
    emit(CompanyListScreenLoading());

    companyListInitial.sort((a, b) {
      return ascending ?
      a.wishesCount.compareTo(b.wishesCount) :
      b.wishesCount.compareTo(a.wishesCount);
    });
    companyList.sort((a, b) {
      return ascending ?
      a.wishesCount.compareTo(b.wishesCount) :
      b.wishesCount.compareTo(a.wishesCount);
    });

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }

  Future<void> filterCompanyList(List<Company> companyListInitial, List<Company> companyList, String filter) async {
    emit(CompanyListScreenLoading());

    companyList = companyListInitial.where((company) =>
        company.companyName.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }

  Future<void> sendReminder() async {
    emit(CompanyListScreenLoading());

    try {
      await _companyRepository.sendReminder();
      emit(const CompanyListScreenSuccessModal("Le rappel a bien été envoyé."));
    } on NetworkException catch (exception) {
      emit(CompanyListScreenErrorModal(exception.message));
    }
  }

  Future<void> deleteCompany(Company company) async {
    emit(CompanyListScreenLoading());

    try {
      await _companyRepository.deleteCompany(company);

      emit(CompanyListScreenDelete(company));
    } on CompanyException catch (exception) {
      emit(CompanyListScreenErrorModal(exception.message));
    } on NetworkException catch (exception) {
      emit(CompanyListScreenErrorModal(exception.message));
    }
  }
}
