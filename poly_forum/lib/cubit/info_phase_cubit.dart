import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/data/models/wish_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart' as ca;
import 'package:poly_forum/resources/company_repository.dart' as co;
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
  final ca.CandidateRepository candidateRepository = ca.CandidateRepository();
  final co.CompanyRepository companyRepository = co.CompanyRepository();

  InfoPhaseCubit() : super(InfoPhaseInitial());

  Future<void> initInfoPhaseAdmin(Phase currentPhase) async {
    HashMap<int, List<Info>> infos = HashMap<int, List<Info>>();

    infos[0] = [
      Info(currentPhase != Phase.inscription, "Phase d'insription terminée")
    ];
    infos[1] = [
      Info(currentPhase != Phase.inscription && currentPhase != Phase.wish,
          "Phase de vœux terminée")
    ];
    infos[2] = [
      Info(currentPhase == Phase.planning, "Le planning a été généré")
    ];

    emit(InfoPhaseLoaded(infos));
  }

  Future<void> initInfoPhaseCandidat(
      CandidateUser candidate, Phase currentPhase) async {
    HashMap<int, List<Info>> infos = HashMap<int, List<Info>>();

    bool isProfileValid = false;
    if (candidate.cv.isNotEmpty &&
        candidate.description.isNotEmpty &&
        candidate.phoneNumber.isNotEmpty) {
      isProfileValid = true;
    }

    int wishCount = 0;
    try {
      List<Wish> wishlist = await candidateRepository.getWishlist(candidate);
      wishCount = wishlist.length;
      infos[0] = [Info(isProfileValid, "Le profil a été complété")];
      infos[1] = [
        Info(wishCount > 0 && currentPhase != Phase.inscription,
            "Les vœux ont été fait")
      ];
      infos[2] = [
        Info(currentPhase == Phase.planning, "Le planning a été généré")
      ];

      emit(InfoPhaseLoaded(infos));
    } on ca.NetworkException catch (exception) {
      emit(InfoPhaseError(exception.message));
    }
  }

  Future<void> initInfoPhaseCompany(
      CompanyUser company, Phase currentPhase) async {
    HashMap<int, List<Info>> infos = HashMap<int, List<Info>>();

    bool isProfileValid = false;
    if (company.description.isNotEmpty && company.phoneNumber.isNotEmpty) {
      isProfileValid = true;
    }

    int wishCount = 0;
    int offerCount = 0;
    try {
      List<CompanyWish> wishlist = await companyRepository.getWishlist(company);
      wishCount = wishlist.length;

      List<Offer> offers =
          await companyRepository.fetchOffersFromCompany(company.id);
      offerCount = offers.length;

      infos[0] = [
        Info(isProfileValid, "Le profil a été complété"),
        Info(offerCount > 0, "Au moins une offre créée"),
      ];
      infos[1] = [
        Info(wishCount > 0 && currentPhase != Phase.inscription,
            "Les vœux ont été fait")
      ];
      infos[2] = [
        Info(currentPhase == Phase.planning, "Le planning a été généré")
      ];

      emit(InfoPhaseLoaded(infos));
    } on ca.NetworkException catch (exception) {
      emit(InfoPhaseError(exception.message));
    }
  }
}
