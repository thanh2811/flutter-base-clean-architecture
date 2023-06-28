import 'dart:async';
import 'dart:io';
import 'dart:math' hide log;

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/constant/enum.dart';
import '../../../../data/model/api/base_response.dart';
import '../../../../data/repository/remote/repository.dart';
import '../../../../di/di.dart';
import '../../../../shared/utils/view_utils.dart';

part 'get_image_event.dart';

part 'get_image_state.dart';

class GetImageBloc extends Bloc<GetImageEvent, GetImageState> {
  final StorageRepository storageRepository = getIt.get<StorageRepository>();

  final List<ImageDataWrapper> imageData = [];
  int maxQuantityPicker = 0;

  // ImagePicker? _imagePicker;

  String singleImagePath = '';

  GetImageBloc() : super(GetImageInitial()) {
    on<GetImageInitialEvent>(_onInitial);
    on<GetImageCameraEvent>(_getImageCamera);
    on<GetImageReorderEvent>(_getImageReorder);
    on<GetImagePickerEvent>(_getImagePicker);
    on<GetImageMultiPickerEvent>(_getMultiImagePicker);
    on<GetImageGetSingleImageUrlEvent>(_getImageUrl);
    on<GetImageGetMultiImageUrlEvent>(_getMultiImageUrl);
    on<GetImageRemoveSingleImageEvent>(_removeSingleImage);
  }

  FutureOr<void> _onInitial(
      GetImageInitialEvent event, Emitter<GetImageState> emit) {
    maxQuantityPicker = event.maxQuantity! + 1;
    imageData.addAll(event.initialData);
    if (event.initialData.length < maxQuantityPicker - 1 &&
        event.isAdd == true) {
      imageData.add(ImageDataWrapper(type: ImageDataType.addNew));
    }
    emit(GetImageSuccessState(imageData: imageData));
  }

  FutureOr<void> _getImageCamera(
      GetImageCameraEvent event, Emitter<GetImageState> emit) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
  }

  FutureOr<void> _getImagePicker(
      GetImagePickerEvent event, Emitter<GetImageState> emit) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      PlatformFile file = result.files.first;
      if (event.shouldCrop) {
        CroppedFile? croppedFile = await ViewUtils.cropImage(
          File(file.path!),
          event.type == ImageType.square
              ? ImageCropStyle.square
              : event.type == ImageType.avatar
                  ? ImageCropStyle.circle
                  : ImageCropStyle.rect,
        );
        if (croppedFile == null) return null;
        singleImagePath = croppedFile.path;
        emit(
          GetImagePickImageSuccessState(
              imagePath: singleImagePath, type: event.type),
        );
      } else {
        singleImagePath = file.path!;
        emit(GetImagePickImageSuccessState(
            imagePath: singleImagePath, type: event.type));
      }
    }
  }

  FutureOr<void> _getMultiImagePicker(
      GetImageMultiPickerEvent event, Emitter<GetImageState> emit) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: maxQuantityPicker > 2 ? true : false);
    if (result != null) {
      List<PlatformFile> files = result.files;
      if (maxQuantityPicker - imageData.length >= 1) {
        imageData.removeLast();
      }
      imageData.addAll(
        files
            .sublist(
                0, min(maxQuantityPicker - imageData.length - 1, files.length))
            .map((e) =>
                ImageDataWrapper(type: ImageDataType.localPath, data: e.path))
            .toList(),
      );
      if (imageData.length + 1 < maxQuantityPicker) {
        imageData.add(ImageDataWrapper(type: ImageDataType.addNew));
      }
      emit(GetImageSuccessState(imageData: imageData));
    }
  }

  FutureOr<void> _removeSingleImage(
      GetImageRemoveSingleImageEvent event, Emitter<GetImageState> emit) {
    imageData.removeAt(event.imagePathIndex);
    if (imageData.length == maxQuantityPicker - 2 &&
            imageData.isNotEmpty &&
            imageData.last.type != ImageDataType.addNew ||
        imageData.isEmpty) {
      imageData.add(ImageDataWrapper(type: ImageDataType.addNew));
    }

    emit(GetImageSuccessState(imageData: imageData));
  }

  FutureOr<void> _getImageUrl(
      GetImageGetSingleImageUrlEvent event, Emitter<GetImageState> emit) async {
    if (singleImagePath.isEmpty) return;
    // uploadImage to get image url
    final imgResponse =
        await storageRepository.uploadImage(imagePath: singleImagePath);
    if (imgResponse.status == ResponseStatus.success) {
      emit(
        GetImageGetSingleImageUrlSuccessState(
            imageUrl: imgResponse.data ?? '', type: event.imageType),
      );
      ViewUtils.toastSuccess('Tải ảnh lên thành công');
    } else {
      ViewUtils.toastWarning('Tải ảnh lên không thành công');
      emit(GetImageGetSingleImageUrlErrorState());
    }
  }

  FutureOr<void> _getImageReorder(
      GetImageReorderEvent event, Emitter<GetImageState> emit) {
    if (imageData[event.oldIndex].type == ImageDataType.addNew ||
        imageData[event.newIndex].type == ImageDataType.addNew) return null;
    final element = imageData.removeAt(event.oldIndex);
    imageData.insert(event.newIndex, element);
    emit(GetImageSuccessState(imageData: imageData));
  }

  FutureOr<void> _getMultiImageUrl(
      GetImageGetMultiImageUrlEvent event, Emitter<GetImageState> emit) async {
    //get the image from the local selection to get url
    final List<String> imagePathList = [];
    for (int i = 0; i < imageData.length; i++) {
      if (imageData[i].type == ImageDataType.localPath) {
        imagePathList.add(imageData[i].data);
      }
    }
    if (imagePathList.isEmpty) {
      emit(GetImageGetMultiImageUrlSuccessState(imageData: imageData));
      return;
    }

    final imgResponse = await storageRepository.uploadMultipleImage(
        imagePathList: imagePathList);
    if (imgResponse.status == ResponseStatus.success) {
      /// replace the type local with type url in [imageData]
      for (int i = 0; i < imageData.length; i++) {
        if (imageData[i].type == ImageDataType.localPath) {
          imageData[i].type = ImageDataType.uri;
          imageData[i].data = imgResponse.data!.first;
          imgResponse.data!.removeAt(0);
        }
      }
      emit(GetImageGetMultiImageUrlSuccessState(imageData: imageData));
    } else {
      ViewUtils.toastWarning('Tải ảnh lên không thành công');
      emit(GetImageGetMultiImageUrlErrorState());
    }
  }

  bool hasNewImageData() {
    for (int i = 0; i < imageData.length; i++) {
      if (imageData[i].type == ImageDataType.localPath) return true;
    }
    return false;
  }
}

class ImageDataWrapper {
  ImageDataType type;
  dynamic data;

  ImageDataWrapper({
    required this.type,
    this.data,
  });
}

enum ImageDataType {
  uri,
  localPath,
  addNew,
}
