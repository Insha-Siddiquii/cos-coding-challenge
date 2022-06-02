import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:image_picker/image_picker.dart';

class UserPhoto extends StatefulWidget {
  const UserPhoto({
    required this.photo,
    Key? key,
  }) : super(key: key);

  final String photo;

  @override
  State<UserPhoto> createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  String? base64Image;

  @override
  void initState() {
    base64Image = widget.photo;
    super.initState();
  }

  UserEditModel userEditModel = UserEditModel(userEmail: '');
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

      setState(() {
        base64Image = base64Encode(imageBytes);
        userEditModel.setUserPhoto(base64Image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _openPhotoSheet(context);
        },
        child: base64Image!.isNotEmpty
            ? CircleAvatar(
                radius: 60.0,
                backgroundImage: MemoryImage(base64Decode(base64Image!)),
                backgroundColor: Colors.transparent,
              )
            : const Icon(
                Icons.face_retouching_natural_rounded,
                size: 100,
                color: AppColors.appSwatchOne,
              ),
      ),
    );
  }
}
