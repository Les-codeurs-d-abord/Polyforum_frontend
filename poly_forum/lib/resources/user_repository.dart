import 'dart:convert';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<User> fetchUser(String mail, String password) async {
    try {
      final body = {
        'email': mail,
        'password': password,
      };

      final uri = Uri.http(kServer, '/api/login/signin');
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonUser = jsonResponse["payload"];

        SharedPreferences.getInstance().then(
            (value) => value.setString(kTokenPref, jsonResponse['token']));

        switch (jsonUser["role"]) {
          case "CANDIDAT":
            final uriCandidate = Uri.http(
              kServer,
              "/api/candidates/${jsonUser["id"]}",
            );
            final resCandidate = await http.get(uriCandidate);
            if (resCandidate.statusCode == 200) {
              var jsonCandidate =
                  jsonDecode(resCandidate.body) as Map<String, dynamic>;

              return CandidateUser.fromJson(jsonCandidate);
            }
            break;
          case "ENTREPRISE":
            final uriCompany = Uri.http(
              kServer,
              "/api/companies/${jsonUser["id"]}",
            );
            final resCompany = await http.get(uriCompany);
            if (resCompany.statusCode == 200) {
              var jsonCompany =
                  jsonDecode(resCompany.body) as Map<String, dynamic>;

              return CompanyUser.fromJson(jsonCompany);
            }
            break;
          case "ADMIN":
            return AdminUser.fromJson(jsonUser);
          default:
        }
      } else if (response.statusCode == 401) {
        throw const UnknowUserException("Identifiants incorrects.");
      }

      throw const NetworkException("Une erreur est survenue.");
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<CandidateUser> getCandidateFromLocalToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString(kTokenPref);

      if (token != null) {
        final user = await getUserFromToken(token);

        if (user is CandidateUser) {
          return user;
        }
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
    throw const NetworkException("Une erreur est survenue.");
  }

  Future<AdminUser> getAdminFromLocalToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString(kTokenPref);

      if (token != null) {
        final user = await getUserFromToken(token);

        if (user is AdminUser) {
          return user;
        }
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
    throw const NetworkException("Une erreur est survenue.");
  }

  Future<User> getUserFromToken(String token) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      };

      final uri = Uri.http(kServer, '/api/login/user');
      final response = await http.get(uri, headers: requestHeaders);

      if (response.statusCode == 200) {
        var jsonUser = jsonDecode(response.body);

        switch (jsonUser["user"]["role"]) {
          case "CANDIDAT":
            return CandidateUser.fromJson(jsonUser);
          case "ENTREPRISE":
            return CompanyUser.fromJson(jsonUser);
          case "ADMIN":
            return AdminUser.fromJson(jsonUser["user"]);
          default:
        }
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }

    throw const NetworkException("Une erreur est survenue.");
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class UnknowUserException implements Exception {
  final String message;
  const UnknowUserException(this.message);
}
