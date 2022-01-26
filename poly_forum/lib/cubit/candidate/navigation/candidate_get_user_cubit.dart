import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/resources/user_repository.dart';
part 'candidate_get_user_state.dart';

class CandidateGetUserCubit extends Cubit<CandidateGetUserState> {
  final UserRepository repository = UserRepository();
  late CandidateUser user;

  CandidateGetUserCubit() : super(CandidateGetUserInitial());

  Future<void> getCandidateFromLocalToken() async {
    try {
      emit(CandidateGetUserLoading());

      user = await repository.getCandidateFromLocalToken();

      emit(CandidateGetUserLoaded());
    } on NetworkException catch (exception) {
      emit(CandidateGetUserError(exception.message));
    }
  }

  CandidateUser getUser() {
    return user;
  }
}
