import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';

part 'info_phase_state.dart';

class Info {
  bool isValid = false;
  String text = "";

  Info(this.isValid, this.text);

  @override
  String toString() {
    return "Valid: $isValid, Text: $text";
  }
}

class InfoPhaseCubit extends Cubit<InfoPhaseState> {
  InfoPhaseCubit() : super(InfoPhaseInitial());

  Future<void> initInfoPhaseCandidat(
      CandidateUser candidate, Phase currentPhase) async {
    HashMap<int, Info> infos = HashMap<int, Info>();

    bool isProfileValid = false;
    if (candidate.cv.isNotEmpty &&
        candidate.description.isNotEmpty &&
        candidate.phoneNumber.isNotEmpty) {
      isProfileValid = true;
    }

    infos[0] = Info(isProfileValid, "Le profil a été complété");
    infos[1] = Info(candidate.wishesCount > 0, "Les vœux ont été fait");
    infos[2] = Info(currentPhase == Phase.planning, "Le planning a été généré");

    emit(InfoPhaseLoaded(infos));
  }

  Future<void> fetchCurrentPhase() async {
    /*  emit(InfoPhaseLoaded()); */
  }
}
