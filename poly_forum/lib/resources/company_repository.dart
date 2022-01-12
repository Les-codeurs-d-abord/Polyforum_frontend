import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/company_model.dart';

class CompanyRepository {
  Future<void> createCompany(String email, String companyName) async {
    final body = {
      'email': email,
      'companyName': companyName,
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 500));

    final uri = Uri.http('localhost:8080', '/api/users/companies');
    final response = await http.post(uri, body: body);

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur à rencontré un problème");
      }
    }
  }

  Future<List<Company>> fetchCompanyList() async {
    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 500));

    final uri = Uri.http('localhost:8080', '/api/users/companyList');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Company> companyList = [];

      for (Map<String, dynamic> companyJson in data) {
        companyList.add(Company.fromJson(companyJson));
      }

      return companyList;
    } else {
      if (response.statusCode == 500) {
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
