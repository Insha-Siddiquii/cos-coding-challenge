// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cos_app/config/constants.dart';
import 'package:flutter_cos_app/domain/auth_repository.dart';
import 'package:flutter_cos_app/ui/edit_profile/model/user_edit.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class RemoteAuthRepository implements AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _controllerGoogleInfo = StreamController<String>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (UserEditModel().getUserEmail().isEmpty) {
      yield AuthenticationStatus.unknown;
    } else {
      yield AuthenticationStatus.authenticated;
    }

    yield* _controller.stream;
  }

  Stream<String> get googleUserInfo async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield* _controllerGoogleInfo.stream;
  }

  @override
  Future<void> logInWithCredentials({
    required String useremail,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: useremail,
        password: password,
      );

      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);

      if (e.code == 'user-not-found') {
        throw Exception(AppConstants.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw Exception(AppConstants.wrongPassword);
      } else {
        throw Exception(AppConstants.somethingWentWrong);
      }
    }
  }

  @override
  Future<void> signUpWithCredentials({
    required String useremail,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: useremail,
        password: password,
      );
      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      if (e.code == 'email-already-in-use') {
        throw Exception(AppConstants.userAlreadyExist);
      } else {
        throw Exception(AppConstants.somethingWentWrong);
      }
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final AuthCredential credential;

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
      } else {
        credential = const AuthCredential(
            providerId: "google.com", signInMethod: "password");
      }
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        _controller.add(AuthenticationStatus.authenticated);
        _controllerGoogleInfo.add(userCredential.user?.email ?? "");
      } on FirebaseAuthException catch (_) {
        throw Exception(AppConstants.signInCancel);
      }
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception(
        e.toString().replaceAll('Exception: ', '') == AppConstants.signInCancel
            ? AppConstants.signInCancel
            : AppConstants.somethingWentWrong,
      );
    }
  }

  @override
  void logOut() {
    auth.signOut();
    UserEditModel().removeUserInfo();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() {
    _controller.close();
    _controllerGoogleInfo.close();
  }
}
