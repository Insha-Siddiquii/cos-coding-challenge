// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cos_app/data/remote/firebase.dart';
import 'package:flutter_cos_app/domain/lcoal_storage_utils.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageUtils.init();
  await Firebase.initializeApp();
  runApp(
    App(
      authenticationRepository: RemoteAuthRepository(),
    ),
  );
}
