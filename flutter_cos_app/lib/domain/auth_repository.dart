// ignore_for_file: unused_local_variable

import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Future<void> logInWithCredentials({
    required String useremail,
    required String password,
  });

  Future<void> signUpWithCredentials({
    required String useremail,
    required String password,
  });

  Future<void> logInWithGoogle();

  void logOut();

  void dispose();
}
