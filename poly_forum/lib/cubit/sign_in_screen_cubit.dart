import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';

part 'sign_in_screen_state.dart';

class SignInScreenCubit extends Cubit<SignInScreenState> {
  final UserRepository _repository;

  SignInScreenCubit(this._repository) : super(SignInScreenInitial());

  Future<void> navigateToHomeScreenEvent(String email, String password) async {
    try {
      emit(SignInScreenLoading());

      final user = await _repository.fetchUserToken(email, password);

      emit(SignInScreenLoaded(user));
    } on NetworkException catch (exception) {
      emit(SignInScreenError(exception.message));
    } on UnknowUserException catch (exception) {
      emit(SignInScreenInvalidUserError(exception.message));
    }
  }
}
