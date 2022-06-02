import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';

abstract class UserInfoRepository {
  UserEditModel getUserProfileInfo();

  void setUserPhoto(String base64Img);

  void setUserEmail(String email);

  String getUserEmail();
  String getUserPhoto();

  void removeUserInfo();
}
