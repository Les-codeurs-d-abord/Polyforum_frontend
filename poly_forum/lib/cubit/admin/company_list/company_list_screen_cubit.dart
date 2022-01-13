import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_list_screen_state.dart';

class CompanyListScreenCubit extends Cubit<CompanyListScreenState> {
  final CompanyRepository _companyRepository;

  CompanyListScreenCubit(this._companyRepository) : super(CompanyListScreenInitial());

  Future<void> companyListEvent() async {
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

  Future<void> sortCompanyListByOfferCountEvent(List<Company> companyListInitial, List<Company> companyList, bool ascending) async {
    emit(CompanyListScreenLoading());

    // TODO
    // companyListInitial.sort((a, b) {
    //   return ascending ?
    //   a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()) :
    //   b.companyName.toLowerCase().compareTo(a.companyName.toLowerCase());
    // });
    // companyList.sort((a, b) {
    //   return ascending ?
    //   a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()) :
    //   b.companyName.toLowerCase().compareTo(a.companyName.toLowerCase());
    // });

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }

  Future<void> filterCompanyList(List<Company> companyListInitial, List<Company> companyList, String filter) async {
    emit(CompanyListScreenLoading());

    companyList = companyListInitial.where((company) =>
        company.companyName.toLowerCase().contains(filter.toLowerCase())
    ).toList();

    emit(CompanyListScreenLoaded(companyListInitial, companyList));
  }
}
