import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:poly_forum/data/models/user_model.dart';

part 'welcome_screen_state.dart';

class WelcomeScreenCubit extends Cubit<WelcomeScreenState> {
  final Repository _repository;

  WelcomeScreenCubit(this._repository) : super(WelcomeScreenInitial());

  Future<void> navigateToSignInScreenEvent() async {
    try {
      emit(WelcomeScreenLoading());

      final user = await _repository.fetchLocalUserTokenWithUserError();

      emit(WelcomeScreenLoaded(user));
      emit(WelcomeScreenInitial());
    } on NetworkException catch (exception) {
      emit(WelcomeScreenError(exception.message));
    } on UserException {
      emit(WelcomeScreenUserUnfound());
    }
  }
}
