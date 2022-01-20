import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/offer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final CompanyRepository _companyRepository;
  final CandidateRepository _candidateRepository;
  final OfferRepository _offerRepository;

  DashboardCubit(this._companyRepository, this._candidateRepository, this._offerRepository) : super(DashboardInitial()) {
    getIndicators();
  }

  Future<void> getIndicators() async {
    try {
      emit(DashboardLoading());
      final companies = await _companyRepository.getCompanies();
      final candidates = await _candidateRepository.getCandidates();
      final offers = await _offerRepository.getOffers();
      emit(DashboardLoaded(companies, candidates, offers));
    } on Exception {
      emit(DashboardError("Une erreur est survenue lors de la récupération des données."));
    }
  }
}