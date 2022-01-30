part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final String pathLogo;
  ImageLoaded(this.pathLogo);
}

class ImageError extends ImageState {
  final String msg;
  ImageError(this.msg);
}
