import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/password_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final PasswordRepository _passwordRepository;

  ChangePasswordCubit(this._passwordRepository) : super(ChangePasswordInitial());

  Future<void> changePassword(User user, String oldPassword, String newPassword) async {
    try {
      emit(ChangePasswordLoading());

      await _passwordRepository.changePassword(user, oldPassword, newPassword);

      emit(ChangePasswordLoaded());
    } on PasswordException catch (exception) {
      emit(ChangePasswordError(exception.message));
    } on NetworkException catch (exception) {
      emit(ChangePasswordError(exception.message));
    } on Exception catch (_) {
      emit(ChangePasswordError("Une erreur inconnue est survenue"));
    }
  }
}
