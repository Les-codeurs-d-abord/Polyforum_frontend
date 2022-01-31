part of 'file_cubit.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileLoaded extends FileState {
  final FileDataModel fileDataModel;
  FileLoaded(this.fileDataModel);
}

class FileUploaded extends FileState {
  final FileDataModel fileDataModel;
  FileUploaded(this.fileDataModel);
}

class FileUploadedWithoutChange extends FileState {}

class FileError extends FileState {
  final String msg;
  FileError(this.msg);
}
