import 'package:poly_forum/data/models/candidate_minimal_model.dart';
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
        List<CompanyMinimal> companies = [];
        for (Map<String, dynamic> i in data) {
          companies.add(CompanyMinimal.fromJson(i));
        }
        return companies;
      } else {
        throw const PlanningException("Planning introuvable");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<List<CandidateMinimal>> fetchFreeCandidatesRequestAtGivenPeriod(
      period) async {
    try {
      if (period == null) {
        throw const PlanningException("Une période est requise");
      }

      String uriLink = 'api/planning/freecandidates/$period';

      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<CandidateMinimal> candidates = [];
        for (Map<String, dynamic> i in data) {
          candidates.add(CandidateMinimal.fromJson(i));
        }
        return candidates;
      } else {
        throw const PlanningException("Planning introuvable");
      }
    } on Exception catch (e) {
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
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw PlanningException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> deleteMeeting(userIdCandidate, userIdCompany, period) async {
    String json =
        jsonEncode(Slot.meetingRequest(userIdCandidate, userIdCompany, period));
    final body = {
      "data": json,
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 2000));

    final uri = Uri.http('localhost:8080', '/api/planning/slot');
    final response =
        await http.delete(uri, body: body).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw PlanningException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<List<CandidateMinimal>> getCandidates() async {
    final uri = Uri.http(kServer, '/api/candidates');
    final response = await http.get(uri).timeout(const Duration(seconds: 2));

    List<CandidateMinimal> candidates = [];

    if (response.statusCode != 200) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw PlanningException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    } else {
      var result = "";

      for (var i = 0; i < response.bodyBytes.length; i++) {
        result += String.fromCharCode(response.bodyBytes[i]);
      }
      final body = jsonDecode(result);

      for (var element in body) {
        CandidateMinimal candidate = CandidateMinimal.fromJson(element);
        candidates.add(candidate);
      }

      return candidates;
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
