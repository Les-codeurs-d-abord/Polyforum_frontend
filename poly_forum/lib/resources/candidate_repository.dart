import 'package:poly_forum/data/models/candidate_model.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/candidate_detail_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/wish_model.dart';
import 'dart:convert';

import 'package:poly_forum/utils/constants.dart';

class CandidateRepository {
  Future<void> createCandidate(
      String email, String lastName, String firstName) async {
    final body = {'email': email, 'lastName': lastName, 'firstName': firstName};

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final uri = Uri.http(kServer, '/api/candidates');
    final response =
    await http.post(uri, body: body).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> editCandidate(CandidateUser candidate, String email) async {
    final body = {
      'email': email,
    };

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final uri = Uri.http(kServer, '/api/users/${candidate.id}');
    final response =
    await http.put(uri, body: body).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> deleteCandidate(CandidateUser candidate) async {
    final uri = Uri.http(kServer, '/api/candidates/${candidate.id}');
    final response = await http.delete(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<List<CandidateUser>> fetchCandidateList() async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final uri = Uri.http(kServer, '/api/candidates');
    final response = await http.get(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<CandidateUser> candidateList = [];

      for (Map<String, dynamic> candidateJson in data) {
        candidateList.add(CandidateUser.fromJson(candidateJson));
      }

      return candidateList;
    } else {
      if (response.statusCode == 500) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<CandidateDetail> getCandidateDetail(int id) async {
    final uri = Uri.http(kServer, '/api/candidates/$id');
    final response = await http.get(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CandidateDetail.fromJson(data);
    } else {
      if (response.statusCode == 404 || response.statusCode == 500) {
        throw CandidateException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> sendReminder() async {
    final uri = Uri.http(kServer, '/api/users/sendRemindersCandidates');
    final response = await http.post(uri).onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable, l'envoi des rappels n'a pas pu être effectué");
    });

    if (response.statusCode != 200) {
      throw const NetworkException("Le serveur a rencontré un problème, l'envoi des rappels n'a pas pu être effectué");
    }
  }

  Future<List<Offer>> fetchOfferList() async {
    try {
      final uri = Uri.http(
        kServer,
        '/api/offer',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // List<Wish> wishlist = await getWishlist(user);
        List<Offer> offerList = [];

        for (Map<String, dynamic> i in data) {
          // bool isInWishlist = false;
          // for (Wish wish in wishlist) {
          //   if (wish.offerId == i['id']) {
          //     isInWishlist = true;
          //     break;
          //   }
          // }
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

  Future<CandidateUser> updateUser(CandidateUser user) async {
    try {
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

  //wishlist
  Future<void> createWish(Offer offer, CandidateUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final body = {
        'candidateProfileId': user.candidateId.toString(),
        'offerId': offer.id.toString()
      };

      final uri = Uri.http(kServer, '/api/wishcandidate');
      final response =
      await http.post(uri, body: body).onError((error, stackTrace) {
        print(error);
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode != 201) {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> deleteWish(Offer offer, CandidateUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final body = {
        'candidateProfileId': user.candidateId.toString(),
        'offerId': offer.id.toString()
      };

      final uri = Uri.http(kServer, '/api/wishcandidate');
      final response =
      await http.delete(uri, body: body).onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode != 200) {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<bool> isOfferInWishlist(Offer offer, CandidateUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final params = {
        'candidateProfileId': user.candidateId.toString(),
        'offerId': offer.id.toString()
      };

      final uri = Uri.http(kServer, '/api/wishcandidate/check', params);
      final response = await http.get(uri).onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['check'] is bool) {
          return data['check'];
        }
      } else if (response.statusCode == 404) {
        return false;
      }
      throw NetworkException(
          "Une erreur est survenue, status code: ${response.statusCode}");
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<List<Wish>> getWishlist(CandidateUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final uri = Uri.http(kServer, '/api/wishcandidate/${user.candidateId}');
      final response = await http.get(uri).onError((error, stackTrace) {
        print(error);
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Wish> wishlist = [];

        for (Map<String, dynamic> i in data) {
          Offer offer = Offer.fromJson(i['offer'] ?? '');
          wishlist.add(Wish.fromJson(i, offer));
        }

        return wishlist;
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> saveChoicesOffer(CandidateUser user, List<Wish> wishlist) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      try {
        List<int> offerIdList = [];

        for (Wish wish in wishlist) {
          offerIdList.add(wish.offerId);
        }

        final body = {
          "data": jsonEncode(offerIdList),
        };

        final uri = Uri.http(kServer, '/api/wishcandidate/${user.candidateId}');
        final response = await http.put(uri, body: body);

        if (response.statusCode != 200) {
          throw const NetworkException("Une erreur est survenue.");
        }
      } on Exception catch (e) {
        throw NetworkException("Une erreur est survenue: ${e.toString()}");
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

class CandidateException implements Exception {
  final String message;
  const CandidateException(this.message);
}
