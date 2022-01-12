import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<CandidateUser> fetchUserToken(String mail, String password) async {
    final body = {
      'email': mail,
      'password': password,
    };

    final uri = Uri.http('localhost:8080', '/api/login/signin');
    final response = await http.post(uri, body: body);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      SharedPreferences.getInstance()
          .then((value) => value.setString('token', jsonResponse['token']));

      // return CandidateUser(mail: jsonResponse['email']);
      return const CandidateUser(
        address: "26 boulevard jean mermoz",
        description: "Je suis dispo h24.",
        email: "bugnone.michael@gmail.com",
        firstName: "Michael",
        lastName: "Bugnone",
        phoneNumber: "0617228153",
      );
    } else {
      // print(response.body);
      // print(response.statusCode);

      if (response.statusCode == 401) {
        throw const UnknowUserException("Identifiants incorrects.");
      }

      throw const NetworkException("Une erreur est survenue.");
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
