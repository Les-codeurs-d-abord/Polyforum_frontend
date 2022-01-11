import 'package:poly_forum/data/models/offer_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateRepository {
  Future<List<Offer>> fetchOfferList(Tag? tag, String? input) async {
    try {
      final queryParameters = {
        'tag': tag?.id.toString(),
        'input': input,
      };

      final uri = Uri.http(
        kServer,
        '/api/offer',
        queryParameters,
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Offer> offerList = [];

        for (Map<String, dynamic> i in data) {
          offerList.add(Offer.fromJson(i));
        }

        return offerList;
      } else {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<List<Tag>> fetchOfferTags() async {
    try {
      final uri = Uri.http(kServer, '/api/offer/tag');
      final response = await http.get(uri).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<Tag> tags = [];
        tags.add(const Tag(id: 0, label: "Tags"));

        for (Map<String, dynamic> i in data) {
          tags.add(Tag.fromJson(i));
        }
        return tags;
      } else {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}
