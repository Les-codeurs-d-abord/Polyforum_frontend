import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:http/http.dart' as http;

class PhasesRepository {
  Future<void> setWishPhase() async {
    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 200));

    final uri = Uri.http('localhost:8080', '/api/phase/setWish');
    final response = await http.post(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw NetworkException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> setPlanningPhase() async {
    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 200));

    final uri = Uri.http('localhost:8080', '/api/phase/setPlanning');
    final response = await http.post(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw NetworkException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> sendSatisfactionSurvey(String surveyLink) async {
    final body = {
      surveyLink: surveyLink
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 200));

    final uri = Uri.http('localhost:8080', '/api/users/sendSatifactionSurvey');
    final response = await http.post(uri, body: body).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 500) {
        throw NetworkException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }
}
