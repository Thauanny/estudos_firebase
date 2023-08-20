import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/src/shared/core/firebase/firebase_remote_config/custom_remote_config.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/impl/firebase_message_local_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/impl/firebase_message_remote_datasource.dart';

import 'src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String env = Env.get("ENV");
  String envLaunch = Env.get("ENV_LAUNCH");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await envFirebaseSettings(envLaunch.isEmpty ? env : envLaunch).inicialize();
  await envFirebaseSettings(envLaunch.isEmpty ? env : envLaunch)
      .getTokenFirebase();
  await CustomRemoteConfig.instance.initialize();

  runApp(
    AppModule(
      env: env,
      envLaunch: envLaunch,
      baseUrl: Env.get("BASE_URL"),
      prefixo: Env.get("PREFIXO"),
    ),
  );
}

FirebaseMessageDataSource envFirebaseSettings(String? env) {
  switch (env) {
    case 'hml':
      return FirebaseMessageRemoteDatasource.instance;

    default:
      return FirebaseMessageLocalDatasource.instance;
  }
}
