import 'dart:io';

import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:poly_forum/data/models/slot_model.dart';
import 'dart:convert';

import 'package:poly_forum/data/models/tag_model.dart';
import 'package:poly_forum/utils/constants.dart';

class CandidateRepository {
  Future<void> createCandidate(String email, String lastName, String firstName) async {
    final body = {
      'email': email,
      'lastName': lastName,
      'firstName': firstName
    };

    // For flex purpose
    await Future.delayed(const Duration(milliseconds: 500));

    final uri = Uri.http('localhost:8080', '/api/candidates');
    final response = await http.post(uri, body: body).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur à rencontré un problème");
      }
    }
  }

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

  Future<Planning> fetchPlanning(CandidateUser candidateUser) async {
    try {
      String uriLink = 'api/planning/candidate/${candidateUser.id}';
      final uri = Uri.http(kServer, uriLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Slot> slots = [];
        for (Map<String, dynamic> i in data) {
          slots.add(Slot.fromJson(i));
        }
        Planning planning = Planning(slots: slots);
        return planning;
      } else {
        throw const CandidateException("Planning introuvable");
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

  Future<CandidateUser> updateUser(CandidateUser user) async {
    try {
/*       var body = {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "phoneNumber": user.phoneNumber,
        "description": user.description,
        "tags": user.tags.toString(),
        "links": user.links.toString(),
      }; */

      /*     final body = {
        "firstName": user.firstName,
        "lastName": user.lastName,
      };

      String json = jsonEncode(user.toJson());
      print(json); */

      String json = jsonEncode(user.toJson());
      final body = {
        "data": json,
      };

      final uri = Uri.http(kServer, '/api/candidates/${user.id}');
      final response = await http.put(uri, body: body);

      if (response.statusCode == 200) {
        var jsonCandidate = jsonDecode(response.body) as Map<String, dynamic>;
        return CandidateUser.fromJson(jsonCandidate);
      } else {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
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
