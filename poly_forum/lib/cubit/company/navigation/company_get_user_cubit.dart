import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
part 'company_get_user_state.dart';

class CompanyGetUserCubit extends Cubit<CompanyGetUserState> {
  final UserRepository repository = UserRepository();
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

  CompanyUser getUser() {
    return user;
  }
}
