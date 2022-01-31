part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final String uri;
  ImageLoaded(this.uri);
}

class ImageError extends ImageState {
  final String msg;
  ImageError(this.msg);
}
