import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/res_repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ResRepository resRepository = ResRepository();

  ImageCubit() : super(ImageInitial());

  Future<void> uploadLogo(Uint8List file, String filename, User user) async {
    try {
      emit(ImageLoading());

      int bytes = file.lengthInBytes;

      if (bytes > 4000000) {
        emit(
          ImageError("Le fichier est trop volumineux (max. 4MB)"),
        );
      } else {
        if (user is CandidateUser) {
          String pathLogo =
              await resRepository.uploadCandidateLogo(file, filename, user);

          emit(ImageLoaded(pathLogo));
        } else if (user is CompanyUser) {
          String pathLogo =
              await resRepository.uploadCampanyLogo(file, filename, user);
          emit(ImageLoaded(pathLogo));
        } else {
          emit(ImageError("Utilisateur non reconnu."));
        }
      }
    } on NetworkException catch (exception) {
      emit(ImageError(exception.message));
    }
  }
}
