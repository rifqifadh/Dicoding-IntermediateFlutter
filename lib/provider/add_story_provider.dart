import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';

import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/add_story.dart';
import 'package:image/image.dart' as img;
import 'package:story_app/data/model/parameters/add_story_params.dart';

class AddStoryProvider extends ChangeNotifier {
  String? imagePath;
  XFile? imageFile;
  final ApiService apiService;

  AddStoryProvider(this.apiService);

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  bool isUploading = false;
  String message = "";
  UploadResponse? uploadResponse;

  String getFileName() {
    return imageFile?.name ?? "Unknown";
  }

  Future<List<int>> getImageBytes() async {
    final bytes = await imageFile?.readAsBytes();

    final compressedImage = await compressImage(bytes ?? [0]);
    return compressedImage;
  }

  Future<void> upload(String description, LatLng? location) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();
      
      final bytes = await getImageBytes();

      uploadResponse = await apiService.uploadFile(
        AddStoryRequestModel(
            description: description,
            fileName: getFileName(),
            bytes: bytes,
            lat: location?.latitude,
            lon: location?.longitude),
      );
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<List<int>> resizeImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    bool isWidthMoreTaller = image.width > image.height;
    int imageTall = isWidthMoreTaller ? image.width : image.height;
    double compressTall = 1;
    int length = imageLength;
    List<int> newByte = bytes;

    do {
      compressTall -= 0.1;

      final newImage = img.copyResize(
        image,
        width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
        height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      );

      length = newImage.length;
      if (length < 1000000) {
        newByte = img.encodeJpg(newImage);
      }
    } while (length > 1000000);

    return newByte;
  }
}
