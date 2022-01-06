import 'package:http/http.dart' as http;

class CompanyRepository {
  Future<void> createCompany(String email, String companyName) async {
    final body = {
      'email': email,
      'companyName': companyName,
    };

    final uri = Uri.http('localhost:8080', '/api/users/companies');
    final response = await http.post(uri, body: body);

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 500));

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CompanyException(response.body);
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

class CompanyException implements Exception {
  final String message;
  const CompanyException(this.message);
}
