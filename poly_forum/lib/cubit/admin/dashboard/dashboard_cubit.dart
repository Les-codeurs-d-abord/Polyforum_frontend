import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/company_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final CompanyRepository _companyRepository;
  final CandidateRepository _candidateRepository;

  DashboardCubit(this._companyRepository, this._candidateRepository) : super(DashboardInitial());

  Future<void> fetchDashboardData() async {
    try {
      emit(DashboardLoading());

      late List<Company> companies;
      late List<CandidateUser> candidates;

      await Future.wait([
        _companyRepository.fetchCompanyList().then((data) => companies = data),
        _candidateRepository.fetchCandidateList().then((data) => candidates = data),
      ]);

      emit(DashboardLoaded(companies, candidates));
    } on Exception {
      emit(const DashboardError("Une erreur est survenue lors de la récupération des données."));
    }
  }
}
