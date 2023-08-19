import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase_messaging/custom_firebase_messaging.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CustomFirebaseMessaging.instance.inicialize();
  await CustomFirebaseMessaging.instance.getTokenFirebase();

  runApp(
    AppModule(
      env: Env.get("ENV"),
      envLaunch: Env.get("ENV_LAUNCH"),
      baseUrl: Env.get("BASE_URL"),
      prefixo: Env.get("PREFIXO"),
    ),
  );
}
