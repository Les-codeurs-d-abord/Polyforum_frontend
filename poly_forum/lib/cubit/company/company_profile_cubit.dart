import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  final CompanyRepository repository = CompanyRepository();

  CompanyProfileCubit() : super(CompanyProfileInitial());

  Future<void> updateCompany(CompanyUser company) async {
    try {
      emit(CompanyProfileLoading());

      await repository.updateCompany(company);

      emit(CompanyProfileLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyProfileError(exception.message));
    }
  }
}
