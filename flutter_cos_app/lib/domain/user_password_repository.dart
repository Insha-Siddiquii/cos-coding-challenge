abstract class UserPasswordRepository {
  Future<bool> changeUserPassword(
    String email,
    String password,
    String confirmPassword,
  );
}
