import 'package:flutter_cos_app/data/local/local_storage.dart';

class UserEditModel {
  UserEditModel({this.userEmail = '', this.userPhoto = ''});
  String userEmail;
  String userPhoto;

  Future<UserEditModel> getUserInfo() async {
    return UserLocalStorageInfo().getUserProfileInfo();
  }

  factory UserEditModel.fromLocalStorage(String email, String img) {
    return UserEditModel(
      userEmail: email,
      userPhoto: img,
    );
  }

  void setUserPhoto(String base64Img) {
    UserLocalStorageInfo().setUserPhoto(base64Img);
  }

  void setUserEmail(String email) {
    UserLocalStorageInfo().setUserEmail(email);
  }

  String getUserEmail() {
    return UserLocalStorageInfo().getUserEmail();
  }

  String getUserPhoto() {
    return UserLocalStorageInfo().getUserPhoto();
  }

  void removeUserInfo() {
    UserLocalStorageInfo().removeUserInfo();
  }
}
