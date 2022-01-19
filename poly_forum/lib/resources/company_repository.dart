import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'dart:convert';

import 'package:poly_forum/utils/constants.dart';

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

  Future<Planning> fetchPlanning(CompanyUser companyUser) async {
    try {
      print('On va tapper l api');
      print(companyUser);
      String uriLink = 'api/planning/company/${companyUser.id}';
      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Slot> slots = [];
        for (Map<String, dynamic> i in data) {
          slots.add(Slot.fromJson(i));
        }
        Planning planning = Planning(slots: slots);
        return planning;
      } else {
        throw const CompanyException("Planning introuvable");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
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
