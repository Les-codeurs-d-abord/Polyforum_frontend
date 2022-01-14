import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/company_user.dart';
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
        var jsonUser = convert.jsonDecode(response.body)["payload"];

        SharedPreferences.getInstance()
            .then((value) => value.setString('token', jsonUser['token']));

        switch (jsonUser["role"]) {
          case "CANDIDAT":
            final uriCandidate = Uri.http(
              kServer,
              "/api/candidates/${jsonUser["id"]}",
            );
            final resCandidate = await http.get(uriCandidate);
            if (resCandidate.statusCode == 200) {
              var jsonCandidate =
                  convert.jsonDecode(resCandidate.body) as Map<String, dynamic>;

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
                  convert.jsonDecode(resCompany.body) as Map<String, dynamic>;

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

  Future<CandidateUser> fetchLocalUserToken() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return const CandidateUser(
          address: "26 boulevard jean mermoz",
          description: "Je suis dispo h24.",
          email: "bugnone.michael@gmail.com",
          firstName: "Michael",
          lastName: "Bugnone",
          phoneNumber: "0617228153",
          role: "CANDIDAT",
        );
      },
    );
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
