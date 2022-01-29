import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';

class PhasesRepository {
  Future<Phase> fetchCurrentPhase() async {
    final uri = Uri.http(kServer, '/api/phase');
    final response = await http.get(uri).onError((error, stackTrace) {
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
    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 100));

    final uri = Uri.http(kServer, '/api/phase/setWish');
    final response = await http.post(uri).onError((error, stackTrace) {
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
    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 100));

    final uri = Uri.http(kServer, '/api/phase/setPlanning');
    final response = await http.post(uri).onError((error, stackTrace) {
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
    final body = {
      "surveyLink": surveyLink
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 100));

    final uri = Uri.http(kServer, '/api/users/sendSatisfactionSurvey');
    final response = await http.post(uri, body: body).onError((error, stackTrace) {
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
