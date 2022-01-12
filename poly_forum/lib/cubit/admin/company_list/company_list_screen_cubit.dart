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

      final companyList = await _companyRepository.fetchCompanyList();

      emit(CompanyListScreenLoaded(companyList));
    } on CompanyException catch (exception) {
      emit(CompanyListScreenError(exception.message));
    } on NetworkException catch (exception) {
      emit(CompanyListScreenError(exception.message));
    }
  }
}
