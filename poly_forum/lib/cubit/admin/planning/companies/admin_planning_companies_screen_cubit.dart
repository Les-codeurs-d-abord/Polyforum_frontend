import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/candidate_minimal_model.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/resources/planning_repository.dart' as pr;

part 'admin_planning_companies_screen_state.dart';

class AdminPlanningCompaniesCubit extends Cubit<AdminPlanningCompaniesState> {
  final CompanyRepository companyRepository = CompanyRepository();
  final pr.PlanningRepository planningRepository = pr.PlanningRepository();

  AdminPlanningCompaniesCubit() : super(AdminPlanningCompaniesInitial());

  Future<List<Company>?> fetchAllCompanies() async {
    try {
      emit(AdminPlanningCompaniesLoading());

      final companiesList = await companyRepository.fetchCompanyList();

      emit(AdminPlanningCompaniesLoaded(companiesList));
    } on NetworkException catch (exception) {
      emit(AdminPlanningCompaniesError(exception.message));
    }
  }

  Future<Planning?> fetchPlanningForGivenCompany(userId) async {
    try {
      emit(AdminPlanningCompaniesLoading());

      final planning = await planningRepository.fetchPlanningWithUserId(userId);

      emit(AdminPlanningCompaniesAndPlanningLoaded(planning));
    } on pr.NetworkException catch (exception) {
      emit(AdminPlanningCompaniesError(exception.message));
    }
  }

  Future<void> removeMeeting(userIdCandidate, userIdCompany, period) async {
    try {
      emit(AdminPlanningCompaniesLoading());

      await planningRepository.deleteMeeting(
          userIdCandidate, userIdCompany, period);

      fetchPlanningForGivenCompany(userIdCompany);
    } on pr.NetworkException catch (exception) {
      emit(AdminPlanningCompaniesError(exception.message));
    }
  }
}
