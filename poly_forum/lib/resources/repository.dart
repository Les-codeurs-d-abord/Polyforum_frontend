import 'package:poly_forum/constants.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository {
  final ip = "10.204.3.35:8080";

// Create storage
  final storage = new FlutterSecureStorage();

  Future<User> fetchUserToken(String mail, String password) async {
    print(mail);

    final response = await http.post(
      Uri.parse('http://$ip/api/login/signin'),
      body: {
        'email': mail,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      String email = data["email"];
      String token = data["token"];

      // Save token
      await storage.write(key: tokenPref, value: token);

      return User(email);
    } else {
      switch (response.statusCode) {
        case 400:
          {
            throw const NetworkException("Email ou mot de passe manquant.");
          }
        case 401:
          {
            throw const NetworkException("Email ou mot de passe incorrect.");
          }
      }
    }

    throw const NetworkException("Impossible de se connecter.");
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
        return const User("mail");
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

class EmailOrPasswordException implements Exception {
  final String message;
  const EmailOrPasswordException(this.message);
}
