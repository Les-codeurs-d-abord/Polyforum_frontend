import 'package:poly_forum/data/models/user_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Repository {
  Future<User> fetchUserToken(String mail, String password) async {
    final body = {
      'email': mail,
      'password': password,
    };

    final uri = Uri.http('10.42.144.92:8080', '/api/login/signin');
    final response = await http.post(uri, body: body);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      return User(mail: jsonResponse['email']);
    } else {
      print(response.body);
      print(response.statusCode);

      throw const NetworkException("Erreur de réseaux générée !");
    }
  }

  Future<User> fetchUserTokenWithError(String mail, String password) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        throw const NetworkException("Erreur de réseaux générée !");
      },
    );
  }

  Future<User> fetchLocalUserToken() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return const User(mail: "mail");
      },
    );
  }

  Future<User> fetchLocalUserTokenWithUserError() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        throw UserException();
      },
    );
  }
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);
}

class UserException implements Exception {}
