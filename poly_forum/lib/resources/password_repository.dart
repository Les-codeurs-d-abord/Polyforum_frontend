import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordRepository {
  Future<void> changePassword(
      User user, String oldPassword, String newPassword) async {
    final body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/users/${user.id}/changePassword');
    final response = await http
        .put(uri, body: body, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 400 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        throw PasswordException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class PasswordException implements Exception {
  final String message;
  const PasswordException(this.message);
}
