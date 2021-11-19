import 'package:poly_forum/data/models/user_model.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Repository {
  Future<User> fetchUserToken(String mail, String password) async {
    print(mail);

    var response =
        await http.get(Uri.parse('http://10.42.140.18:8080/api/login/info'));

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      /* var itemCount = jsonResponse['totalItems']; */
      /* print('Number of books about http: $itemCount.'); */
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

/*     HttpClient client = new HttpClient();
    client
        .getUrl(Uri.parse("http://10.42.140.18:8080/api/login/signin"))
        .then((HttpClientRequest request) {
      print("oui");
      Map data = {'email': 'mika@gmail.com', 'password': 'mika'};

      request.write(json.encode(data));

      return request.close();
    }).then((HttpClientResponse response) {
      print(response);
    }); */

    return const User(mail: "mail");

/*     return Future.delayed(
      const Duration(seconds: 0),
      () {
        
      },
    ); */
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
