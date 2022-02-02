import 'dart:convert';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResRepository {
  Future<String> uploadCVCandidate(
      Uint8List file, String filename, CandidateUser candidate) async {
    return await uploadCV(
        file, filename, '/api/candidates/${candidate.id}/uploadCV', "cv");
  }

  Future<String> uploadCVOffer(
      Uint8List file, String filename, Offer offer) async {
    return await uploadCV(
        file, filename, '/api/offer/${offer.id}/upload', "offer");
  }

  Future<String> uploadCV(
      Uint8List file, String fileName, String unencodedPath, String key) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      final token = pref.getString(kTokenPref);
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer $token",
      };

      final uri = Uri.http(kServer, unencodedPath);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile.fromBytes(
          key,
          file,
          filename: fileName,
          contentType: MediaType.parse(lookupMimeType(fileName)!),
        ),
      );
      request.headers.addAll(requestHeaders);

      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        return await streamedResponse.stream.bytesToString();
      } else if (streamedResponse.statusCode == 400) {
        throw const FileToBigException(
            "Le fichier envoyé est trop volumineux.");
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${streamedResponse.statusCode}");
      }
    } on Exception catch (e) {
      throw NetworkException("Une erreur est survenue: ${e.toString()}");
    }
  }

  Future<String> uploadCampanyLogo(
      Uint8List file, String finename, CompanyUser company) async {
    return await uploadLogo(
        file, finename, '/api/companies/${company.id}/uploadLogo');
  }

  Future<String> uploadCandidateLogo(
      Uint8List file, String filename, CandidateUser user) async {
    return await uploadLogo(
        file, filename, '/api/candidates/${user.id}/uploadLogo');
  }

  Future<String> uploadLogo(
      Uint8List file, String filename, String unencodedPath) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final pref = await SharedPreferences.getInstance();
      final token = pref.getString(kTokenPref);
      Map<String, String> requestHeaders = {
        'Authorization': "Bearer $token",
      };

      final uri = Uri.http(kServer, unencodedPath);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
        http.MultipartFile.fromBytes(
          "logo",
          file,
          filename: filename,
          contentType: MediaType.parse(lookupMimeType(filename)!),
        ),
      );

      request.headers.addAll(requestHeaders);

      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        return await streamedResponse.stream.bytesToString();
      } else if (streamedResponse.statusCode == 400) {
        throw const FileToBigException(
            "Le fichier envoyé est trop volumineux.");
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${streamedResponse.statusCode}");
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

class FileToBigException implements Exception {
  final String message;
  const FileToBigException(this.message);
}
