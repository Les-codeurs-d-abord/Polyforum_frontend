import 'package:http/http.dart' as http;

class CandidateRepository {
  Future<void> createCandidate(String email, String lastname, String firstname) async {
    final body = {
      'email': email,
      'lastname': lastname,
      'firstname': firstname
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 500));

    final uri = Uri.http('localhost:8080', '/api/users/candidates');
    final response = await http.post(uri, body: body);

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur à rencontré un problème");
      }
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class CandidateException implements Exception {
  final String message;
  const CandidateException(this.message);
}
