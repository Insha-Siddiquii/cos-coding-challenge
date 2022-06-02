import 'package:flutter_cos_app/domain/lcoal_storage_utils.dart';
import 'package:flutter_cos_app/domain/user_info_repository.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';

class UserLocalStorageInfo implements UserInfoRepository {
  @override
  UserEditModel getUserProfileInfo() {
    return UserEditModel.fromLocalStorage(
      LocalStorageUtils.getString(key: 'userEmail')!,
      LocalStorageUtils.getString(key: 'userPhoto') ?? '',
    );
  }

  @override
  void setUserPhoto(String base64Img) {
    LocalStorageUtils.setString('userPhoto', base64Img);
  }

  @override
  void setUserEmail(String email) {
    LocalStorageUtils.setString('userEmail', email);
  }

  @override
  String getUserEmail() {
    return LocalStorageUtils.getString(key: 'userEmail') ?? '';
  }

  @override
  String getUserPhoto() {
    return LocalStorageUtils.getString(key: 'userPhoto')!;
  }

  @override
  void removeUserInfo() {
    LocalStorageUtils.remove('userEmail');
    LocalStorageUtils.remove('userPhoto');
  }
}
