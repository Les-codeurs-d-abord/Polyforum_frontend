import 'package:poly_forum/data/models/user_model.dart';

class Repository {
  Future<User> fetchUserToken(String mail, String password) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return const User(mail: "mail");
      },
    );
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
