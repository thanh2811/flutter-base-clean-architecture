import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../data/constant/enum.dart';
import '../../data/resources/resources.dart';

class ViewUtils {
  static void unFocusView() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static toastWarning(String text) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);

  static toastSuccess(String text) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.success,
      textColor: AppColor.white,
      fontSize: 16.0);

  Future<DateTime?> getDatePicker(BuildContext context) async {
    final DateTime? select = await showDatePicker(
        context: context,
        locale: const Locale("vi"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    return select;
  }

  static Future<CroppedFile?> cropImage(
          File imageFile, ImageCropStyle imageCropStyle) async =>
      await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        cropStyle: imageCropStyle == ImageCropStyle.circle
            ? CropStyle.circle
            : CropStyle.rectangle,
        aspectRatio: imageCropStyle == ImageCropStyle.circle ||
                imageCropStyle == ImageCropStyle.square
            ? const CropAspectRatio(ratioX: 1, ratioY: 1)
            : const CropAspectRatio(ratioX: 16, ratioY: 9),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Chỉnh sửa',
              toolbarColor: AppColor.primaryColor,
              activeControlsWidgetColor: AppColor.primaryColor,
              showCropGrid: false,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Chỉnh sửa',
          ),
        ],
      );
}
