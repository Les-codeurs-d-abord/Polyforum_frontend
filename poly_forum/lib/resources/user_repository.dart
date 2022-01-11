import 'package:poly_forum/data/models/user_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<User> fetchUserToken(String mail, String password) async {
    try {
      final body = {
        'email': mail,
        'password': password,
      };

      final uri = Uri.http(kServer, '/api/login/signin');
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        SharedPreferences.getInstance()
            .then((value) => value.setString('token', jsonResponse['token']));

        return User(mail: jsonResponse['email']);
      } else {
        if (response.statusCode == 401) {
          throw const UnknowUserException("Identifiants incorrects.");
        }

        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<User> fetchLocalUserToken() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return const User(mail: "mail");
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
