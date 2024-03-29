import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_detail_model.dart';
import 'package:poly_forum/data/models/company_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/company_wish.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyRepository {
  Future<List<CandidateUser>> getCandidateList() async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(
        kServer,
        '/api/candidates',
      );
      final response = await http
          .get(uri, headers: requestHeaders)
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<CandidateUser> candidateList = [];

        for (Map<String, dynamic> i in data) {
          candidateList.add(CandidateUser.fromJson(i));
        }

        return candidateList;
      } else {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      print(e);
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> createCompany(String email, String companyName) async {
    final body = {
      'email': email,
      'companyName': companyName,
    };

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/companies/');
    final response = await http
        .post(uri, body: body, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 201) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> editCompany(Company company, String email) async {
    final body = {
      'email': email,
    };

    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/users/${company.id}');
    final response = await http
        .put(uri, body: body, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> deleteCompany(Company company) async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/companies/${company.id}');
    final response = await http
        .delete(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 404 || response.statusCode == 409) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<void> updateCompany(CompanyUser user) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      String json = jsonEncode(user.toJson());
      final body = {
        "data": json,
      };

      final uri = Uri.http(kServer, '/api/companies/${user.id}');
      final response = await http.put(uri, body: body, headers: requestHeaders);

      if (response.statusCode != 200) {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<List<Company>> fetchCompanyList() async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/companies');
    final response = await http
        .get(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Company> companyList = [];

      for (Map<String, dynamic> companyJson in data) {
        companyList.add(Company.fromJson(companyJson));
      }

      return companyList;
    } else {
      if (response.statusCode == 500) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<CompanyDetail> getCompanyDetail(int id) async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/companies/$id');
    final response = await http
        .get(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException("Le serveur est injoignable");
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CompanyDetail.fromJson(data);
    } else {
      if (response.statusCode == 404 || response.statusCode == 500) {
        throw CompanyException(response.body);
      } else {
        throw const NetworkException("Le serveur a rencontré un problème");
      }
    }
  }

  Future<List<Offer>> fetchOffersFromCompany(int id) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(kServer, '/api/companies/$id/offer');

      final response = await http
          .get(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Offer> offersList = [];

        for (Map<String, dynamic> offerJson in data) {
          offersList.add(Offer.fromJson(offerJson));
        }

        return offersList;
      } else {
        if (response.statusCode == 404 || response.statusCode == 500) {
          throw CompanyException(response.body);
        } else {
          throw const NetworkException("Le serveur a rencontré un problème");
        }
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<Offer> createOffer(Offer offer) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      String json = jsonEncode(offer.toJson());
      final body = {
        "data": json,
      };

      final uri = Uri.http(kServer, '/api/offer/${offer.companyId}');
      final response = await http
          .post(uri, body: body, headers: requestHeaders)
          .onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Offer.fromJson(data);
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> deleteOffer(Offer offer) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(kServer, '/api/offer/${offer.id}');
      final response = await http
          .delete(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode != 200) {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<Offer> updateOffer(Offer offer) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      String json = jsonEncode(offer.toJson());
      final body = {
        "data": json,
      };

      final uri = Uri.http(kServer, '/api/offer/${offer.id}');
      final response = await http.put(uri, body: body, headers: requestHeaders);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Offer.fromJson(data);
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<void> sendReminder() async {
    await Future.delayed(const Duration(milliseconds: kDelayQuery));

    final pref = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': "Bearer ${pref.getString(kTokenPref)}",
    };

    final uri = Uri.http(kServer, '/api/users/sendRemindersCompanies');
    final response = await http
        .post(uri, headers: requestHeaders)
        .onError((error, stackTrace) {
      throw const NetworkException(
          "Le serveur est injoignable, l'envoi des rappels n'a pas pu être effectué");
    });

    if (response.statusCode != 200) {
      throw const NetworkException(
          "Le serveur a rencontré un problème, l'envoi des rappels n'a pas pu être effectué");
    }
  }

  //wishlist
  Future<void> createWish(CompanyUser company, CandidateUser candidate) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(kServer,
          '/api/wishcompany/${company.campanyProfileId}/${candidate.candidateId}');
      final response = await http
          .post(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
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

  Future<void> deleteWish(CompanyUser company, CandidateUser candidate) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(kServer,
          '/api/wishcompany/${company.campanyProfileId}/${candidate.candidateId}');
      final response = await http
          .delete(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode != 200) {
        throw const NetworkException("Une erreur est survenue.");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<bool> isOfferInWishlist(
      CompanyUser company, CandidateUser candidate) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri = Uri.http(kServer,
          '/api/wishcompany/check/${company.campanyProfileId}/${candidate.candidateId}');
      final response = await http
          .get(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
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

  Future<List<CompanyWish>> getWishlist(CompanyUser company) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      final uri =
          Uri.http(kServer, '/api/wishcompany/${company.campanyProfileId}');
      final response = await http
          .get(uri, headers: requestHeaders)
          .onError((error, stackTrace) {
        print(error);
        throw const NetworkException("Le serveur est injoignable");
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<CompanyWish> wishlist = [];

        for (Map<String, dynamic> i in data) {
          CandidateUser candidateUser =
              CandidateUser.fromJson(i['candidate_profile'] ?? '');
          wishlist.add(CompanyWish.fromJson(i, candidateUser));
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

  Future<void> updateWishlist(
      CompanyUser company, List<CompanyWish> wishlist) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer ${pref.getString(kTokenPref)}",
      };

      try {
        List<int> offerIdList = [];

        for (CompanyWish wish in wishlist) {
          offerIdList.add(wish.candidateProfileId);
        }

        final body = {
          "data": jsonEncode(offerIdList),
        };

        final uri =
            Uri.http(kServer, '/api/wishcompany/${company.campanyProfileId}');
        final response =
            await http.put(uri, body: body, headers: requestHeaders);

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

class CompanyException implements Exception {
  final String message;
  const CompanyException(this.message);
}
