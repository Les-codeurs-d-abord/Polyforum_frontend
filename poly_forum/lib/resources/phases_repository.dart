import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhasesRepository {
  Future<Phase> fetchCurrentPhase() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(kTokenPref);
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer $token",
    };

    final uri = Uri.http(kServer, '/api/phase');
    final response = await http
        .get(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const PhaseException("Le serveur est injoignable");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Phase.fromJson(data);
    } else {
      if (response.statusCode == 500) {
        throw PhaseException(response.body);
      } else {
        throw const PhaseException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> setWishPhase() async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(kTokenPref);
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer $token",
    };

    final uri = Uri.http(kServer, '/api/phase/setWish');
    final response = await http
        .post(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const PhaseException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw PhaseException(response.body);
      } else {
        throw const PhaseException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> setPlanningPhase() async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(kTokenPref);
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer $token",
    };

    final uri = Uri.http(kServer, '/api/phase/setPlanning');
    final response = await http
        .post(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const PhaseException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw PhaseException(response.body);
      } else {
        throw const PhaseException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> sendSatisfactionSurvey(String surveyLink) async {
    final body = {"surveyLink": surveyLink};

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(kTokenPref);
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer $token",
    };

    final uri = Uri.http(kServer, '/api/users/sendSatisfactionSurvey');
    final response = await http
        .post(uri, body: body, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const PhaseException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        throw PhaseException(response.body);
      } else {
        throw const PhaseException("Le serveur a rencontré un problème");
      }
    }
  }
}

class PhaseException implements Exception {
  final String message;
  const PhaseException(this.message);
}
