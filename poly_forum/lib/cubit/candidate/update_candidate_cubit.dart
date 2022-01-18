import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';

part 'update_candidate_state.dart';

class UpdateCandidateCubit extends Cubit<UpdateCandidateState> {
  final CandidateRepository repository = CandidateRepository();

  UpdateCandidateCubit() : super(UpdateCandidateInitial());

  Future<void> updateUserEvent(CandidateUser user) async {
    try {
      emit(UpdateCandidateLoading());

      final newUser = await repository.updateUser(user);

      emit(UpdateCandidateLoaded(newUser));
    } on NetworkException catch (exception) {
      emit(UpdateCandidateError(exception.message));
    }
  }
}
