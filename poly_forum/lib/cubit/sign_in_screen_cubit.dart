import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';

part 'sign_in_screen_state.dart';

class SignInScreenCubit extends Cubit<SignInScreenState> {
  final UserRepository _repository;

  SignInScreenCubit(this._repository) : super(SignInScreenInitial());

  Future<void> navigateToHomeScreenEvent(String email, String password) async {
    try {
      emit(SignInScreenLoading());

      final user = await _repository.fetchUser(email, password);

      emit(SignInScreenLoaded(user));
    } on UnknowUserException catch (exception) {
      emit(SignInScreenInvalidUserError(exception.message));
    } on NetworkException catch (exception) {
      emit(SignInScreenError(exception.message));
    }
  }
}
