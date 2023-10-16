import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
ImagePicker picker = ImagePicker();
late XFile? file;
void main() {
  runApp(MaterialApp(
    home : SafeArea(
      child: Scaffold(
        body : Center(
          child : Image.asset('assets/image/anhdep.png')
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            file = await picker!.pickImage(source: ImageSource.gallery, imageQuality: 100);
            await crop();
          },
        )
      )
    ),
  ));
}

Future crop () async {
  File? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
  );

}