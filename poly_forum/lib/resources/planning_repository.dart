import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_minimal_model.dart';
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'dart:convert';

import 'package:poly_forum/utils/constants.dart';

class PlanningRepository {
  Future<Planning> fetchPlanning(CandidateUser candidateUser) async {
    try {
      String uriLink = 'api/planning/candidate/${candidateUser.id}';
      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Slot> slots = [];
        for (Map<String, dynamic> i in data) {
          slots.add(Slot.fromJson(i));
        }
        Planning planning = Planning(slots: slots);
        return planning;
      } else {
        throw const PlanningException("Planning introuvable");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<Planning> fetchPlanningWithUserId(int userId) async {
    try {
      String uriLink = 'api/planning/$userId';
      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Slot> slots = [];
        for (Map<String, dynamic> i in data) {
          slots.add(Slot.fromJson(i));
        }
        Planning planning = Planning(slots: slots);
        return planning;
      } else {
        throw const PlanningException("Planning introuvable");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<List<CompanyMinimal>> fetchFreeCompaniesRequestAtGivenPeriod(
      period) async {
    try {
      if (period == null) {
        throw const PlanningException("Une période est requise");
      }

      String uriLink = 'api/planning/freecompanies/$period';

      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        List<CompanyMinimal> companies = [];
        for (Map<String, dynamic> i in data) {
          companies.add(CompanyMinimal.fromJson(i));
        }
        return companies;
      } else {
        throw const PlanningException("Planning introuvable");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> createMeeting(userIdCandidate, userIdCompany, period) async {
    String json =
        jsonEncode(Slot.meetingRequest(userIdCandidate, userIdCompany, period));
    final body = {
      "data": json,
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 2000));

    final uri = Uri.http('localhost:8080', '/api/planning/meeting');
    final response =
        await http.post(uri, body: body).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      throw const NetworkException("Le serveur est injoignable");
    });

    print(response.statusCode);
    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw PlanningException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class PlanningException implements Exception {
  final String message;
  const PlanningException(this.message);
}
