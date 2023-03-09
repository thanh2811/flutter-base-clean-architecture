import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:base_project/shared/utils/view_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/constant/enum.dart';
import '../../../data/model/api/base_response.dart';
import '../../../data/repository/remote/repository.dart';

part 'get_image_event.dart';
part 'get_image_state.dart';

class GetImageBloc extends Bloc<GetImageEvent, GetImageState> {
  final List<List<String>> imagePathList = [];
  final StorageRepository storageRepository;
  // ImagePicker? _imagePicker;

  final List<String> currentImagePathList = [];

  GetImageBloc({required this.storageRepository}) : super(GetImageInitial()) {
    on<GetImageCameraEvent>(_getImageCamera);
    on<GetImagePickerEvent>(_getImagePicker);
    on<GetImageGetImageUrlEvent>(_getImageUrl);
    on<GetImageRemoveSingleImageEvent>(_removeSingleImage);
  }

  FutureOr<void> _getImageCamera(
      GetImageCameraEvent event, Emitter<GetImageState> emit) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
  }

  void initImagePathListWithAlbumSize(int index) {
    for (var i = 0; i < index; i++) {
      imagePathList.add([]);
    }
  }

  FutureOr<void> _getImagePicker(
      GetImagePickerEvent event, Emitter<GetImageState> emit) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    // if (result != null) {
    //   PlatformFile file = result.files.first;
    //   log(file.path.toString());
    // }

    // _imagePicker ??= ImagePicker();
    // final result = await _imagePicker?.pickImage(source: ImageSource.gallery);
    if (result != null) {
      PlatformFile file = result.files.first;
      if (event.shouldCrop) {
        CroppedFile? croppedFile = await ViewUtils.cropImage(
          File(file.path!),
          event.type == ImageType.avatar
              ? ImageCropStyle.circle
              : ImageCropStyle.rect,
        );
        if (croppedFile == null) return null;
        currentImagePathList.add(croppedFile.path);
        emit(
          GetImagePickImageSuccessState(
              imagePath: croppedFile.path, type: event.type),
        );
      } else {
        log('get image not croppedFile');
        emit(GetImagePickImageSuccessState(
            imagePath: file.path!, type: event.type));
        currentImagePathList.add(file.path!);
      }
    }
  }

  FutureOr<void> _removeSingleImage(
      GetImageRemoveSingleImageEvent event, Emitter<GetImageState> emit) {
    currentImagePathList.removeAt(event.imagePathIndex);
    emit(GetImageRemoveSingleImageSuccessState());
  }

  FutureOr<void> _getImageUrl(
      GetImageGetImageUrlEvent event, Emitter<GetImageState> emit) async {
    // uploadImage to get image url
    final imgResponse = await storageRepository.uploadImage(
        imagePath: event.imagePath, imageType: event.imageType);
    if (imgResponse.status == ResponseStatus.success) {
      emit(
        GetImageGetImageUrlSuccessState(
            imageUrl: imgResponse.data ?? '', type: event.imageType),
      );
    } else {
      emit(GetImageGetImageUrlErrorState());
    }
  }
}
