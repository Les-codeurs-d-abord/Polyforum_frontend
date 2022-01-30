import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:http/http.dart' as http;

class ResRepository {
  Future<String> uploadCampanyLogo(
      PlatformFile file, CompanyUser company) async {
    return await uploadLogo(file, '/api/companies/${company.id}/uploadLogo');
  }

  Future<String> uploadCandidateLogo(
      PlatformFile file, CandidateUser user) async {
    return await uploadLogo(file, '/api/candidates/${user.id}/uploadLogo');
  }

  Future<String> uploadLogo(PlatformFile file, String unencodedPath) async {
    try {
      await Future.delayed(const Duration(milliseconds: kDelayQuery));

      final uri = Uri.http(kServer, unencodedPath);

      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile(
          'logo',
          file.readStream!.cast(),
          file.size,
          filename: file.name,
          contentType: MediaType.parse(lookupMimeType(file.name)!),
        ),
      );
      var response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else if (response.statusCode == 400) {
        throw const FileToBigException(
            "Le fichier envoyé est trop volumineux.");
      } else {
        throw NetworkException(
            "Une erreur est survenue, status code: ${response.statusCode}");
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
