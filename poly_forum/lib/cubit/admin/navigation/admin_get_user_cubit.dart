import 'package:bloc/bloc.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/resources/user_repository.dart';

part 'admin_get_user_state.dart';

class AdminGetUserCubit extends Cubit<AdminGetUserState> {
  final UserRepository repository = UserRepository();
  late AdminUser user;

  AdminGetUserCubit() : super(AdminGetUserInitial());

  Future<void> getAdminFromLocalToken() async {
    try {
      emit(AdminGetUserLoading());

      user = await repository.getAdminFromLocalToken();

      emit(AdminGetUserLoaded());
    } on NetworkException catch (exception) {
      emit(AdminGetUserError(exception.message));
    }
  }

  AdminUser getUser() {
    return user;
  }
}
