import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/offer_model.dart';
import 'package:poly_forum/resources/res_repository.dart';

part 'file_state.dart';

class FileDataModel {
  final String name;
  final String mime;
  final int bytes;
  final String url;
  final Uint8List fileData;
  String uri;

  FileDataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.url,
    required this.fileData,
    this.uri = "",
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}

class FileCubit extends Cubit<FileState> {
  final ResRepository resRepository = ResRepository();

  FileCubit() : super(FileInitial());

  FileDataModel? fileDataModel;

  Future<void> setCV(DropzoneViewController controller, dynamic event) async {
    emit(FileLoading());

    fileDataModel = FileDataModel(
      name: event.name,
      mime: await controller.getFileMIME(event),
      bytes: await controller.getFileSize(event),
      url: await controller.createFileUrl(event),
      fileData: await controller.getFileData(event),
    );

    int bytes = await controller.getFileSize(event);
    if (bytes > 4000000) {
      fileDataModel = null;
      emit(
        FileError("Le fichier est trop volumineux (max. 4MB)"),
      );
    } else {
      emit(FileLoaded(fileDataModel!));
    }
  }

  Future<String?> uploadCV(dynamic model) async {
    try {
      emit(FileLoading());

      if (model is CandidateUser) {
        if (fileDataModel != null) {
          fileDataModel!.uri = await resRepository.uploadCVCandidate(
              fileDataModel!.fileData, fileDataModel!.name, model);
          emit(FileUploaded(fileDataModel!));
          return fileDataModel!.uri;
        } else {
          emit(FileUploadedWithoutChange());
          return model.cv;
        }
      } else if (model is Offer) {
        if (fileDataModel != null) {
          fileDataModel!.uri = await resRepository.uploadCVOffer(
              fileDataModel!.fileData, fileDataModel!.name, model);

          emit(FileUploaded(fileDataModel!));
          return fileDataModel!.uri;
        } else {
          emit(FileUploadedWithoutChange());
          return model.offerFile;
        }
      } else {
        emit(FileError("Utilisateur non reconnu."));
      }
    } on NetworkException catch (exception) {
      emit(FileError(exception.message));
    }

    return null;
  }
}
