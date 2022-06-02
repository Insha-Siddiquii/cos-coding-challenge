import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:image_picker/image_picker.dart';

class VehiclePhotoUploader extends StatefulWidget {
  const VehiclePhotoUploader({Key? key, required this.onImageSelected})
      : super(key: key);

  final Function(String base64Image) onImageSelected;

  @override
  State<VehiclePhotoUploader> createState() => _VehiclePhotoUploaderState();
}

class _VehiclePhotoUploaderState extends State<VehiclePhotoUploader> {
  File? _imageFile;
  _openPhotoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppConstants.takePhoto),
              onTap: () {
                _gotoImagePicker('camera');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppConstants.chooseGallery),
              onTap: () {
                _gotoImagePicker('gallery');
              },
            ),
          ],
        ),
      ),
    );
  }

  _gotoImagePicker(String source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image;
    if (source == 'camera') {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      List<int> imageBytes = File(image.path).readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      widget.onImageSelected(base64Image);
      setState(() {
        _imageFile = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _imageFile != null
          ? Image.file(_imageFile!)
          : ElevatedButton(
              onPressed: () {
                _openPhotoSheet(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: AppColors.appTertiary,
                  textStyle: const TextStyle(
                    fontSize: 15,
                  )),
              child: const Text(AppConstants.vehiclePhotoText),
            ),
    );
  }
}
