import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/offer_model.dart';


class OfferRepository {

  Future<List<Offer>> getOffers() async {
    List<Offer> offers = [];
    await Future.delayed(const Duration(milliseconds: 500));

    final uri = Uri.http('localhost:8080', '/api/offer');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    } else {
      
      var result = "";
      
      for (var i = 0; i < response.bodyBytes.length; i++) {
        result += String.fromCharCode(response.bodyBytes[i]);
      }
      final body = jsonDecode(result);

      for (var element in body) {
        Offer offer = new Offer(email: element['email'], name: element['name'], description: element['description']);
        offers.add(offer);
      }

      return  offers;
    }
  }

}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class CandidateException implements Exception {
  final String message;
  const CandidateException(this.message);
}
