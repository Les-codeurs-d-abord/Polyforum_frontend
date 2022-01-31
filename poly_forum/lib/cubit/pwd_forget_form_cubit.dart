import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'pwd_forget_form_state.dart';

class PwdForgetFormCubit extends Cubit<PwdForgetFormState> {
  final UserRepository _userRepository;

  PwdForgetFormCubit(this._userRepository) : super(PwdForgetFormInitial());

  Future<void> resetForgottenPassword(String email) async {
    try {
      emit(PwdForgetFormLoading());

      await _userRepository.resetForgottenPassword(email);

      emit(PwdForgetFormLoaded());
    } on UnknowUserException catch (exception) {
      emit(PwdForgetFormError(exception.message));
    } on NetworkException catch (exception) {
      emit(PwdForgetFormError(exception.message));
    } on Exception catch (_) {
      emit(const PwdForgetFormError("Une erreur inconnue est survenue"));
    }
  }
}
