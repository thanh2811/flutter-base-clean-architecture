part of 'get_image_bloc.dart';

abstract class GetImageState {}

class GetImageInitial extends GetImageState {
  GetImageInitial();
}

class GetImagePickImageSuccessState extends GetImageState {
  final String imagePath;
  final ImageType type;

  GetImagePickImageSuccessState(
      {required this.imagePath, this.type = ImageType.none});

  // @override
  // List<Object?> get props => [imagePath, type];
}

class GetImageRemoveSingleImageSuccessState extends GetImageState {}

class GetImageGetImageUrlSuccessState extends GetImageState {
  final String imageUrl;
  final ImageType type;

  GetImageGetImageUrlSuccessState(
      {required this.imageUrl, this.type = ImageType.none});
}

class GetImageGetImageUrlErrorState extends GetImageState {}
