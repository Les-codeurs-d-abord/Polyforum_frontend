import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/company_repository.dart' as c;
import 'package:poly_forum/resources/user_repository.dart';
part 'company_get_user_state.dart';

class CompanyGetUserCubit extends Cubit<CompanyGetUserState> {
  final UserRepository repository = UserRepository();
  final c.CompanyRepository companyRepository = c.CompanyRepository();

  late CompanyUser user;

  CompanyGetUserCubit() : super(CompanyGetUserInitial());

  Future<void> getCompanyFromLocalToken() async {
    try {
      emit(CompanyGetUserLoading());

      user = await repository.getCompanyFromLocalToken();

      emit(CompanyGetUserLoaded());
    } on NetworkException catch (exception) {
      emit(CompanyGetUserError(exception.message));
    }
  }

  void setUser(CompanyUser user) {
    this.user = user;
  }

  CompanyUser getUser() {
    return user;
  }
}
