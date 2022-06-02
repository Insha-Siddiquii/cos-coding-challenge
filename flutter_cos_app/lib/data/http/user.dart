import 'package:flutter_cos_app/domain/user_password_repository.dart';

class UserProfileServices extends UserPasswordRepository {
  @override
  Future<bool> changeUserPassword(
      String email, String password, String confirmPassword) async {
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        return true;
      });
      return true;
    } catch (e) {
      throw Exception('Error adding changing password');
    }
  }
}
