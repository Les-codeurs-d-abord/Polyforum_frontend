import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_form_state.dart';

class CompanyFormCubit extends Cubit<CompanyFormState> {

  final CompanyRepository _companyRepository;

  CompanyFormCubit(this._companyRepository) : super(CompanyFormInitial());

  Future<void> createCompany(String email, String companyName) async {
    try {
      emit(CompanyFormLoading());

      await _companyRepository.createCompany(email, companyName);

      emit(CompanyFormLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyFormError(exception.message));
    } on CompanyException catch (exception) {
      emit(CompanyFormError(exception.message));
    } on Exception catch (_) {
      emit(const CompanyFormError("Une erreur inconnue est survenue"));
    }
  }

}
