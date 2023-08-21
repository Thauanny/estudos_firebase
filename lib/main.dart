import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/impl/firebase_message_local_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/impl/firebase_message_remote_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/firebase_remote_configurtion.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/impl/firebase_remote_configuration_local_impl.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/impl/firebase_remote_configuration_remote_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String env = Env.get("ENV");
  String envLaunch = Env.get("ENV_LAUNCH");
  String baseUrl = Env.get("BASE_URL");
  String prefixo = Env.get("PREFIXO");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await envFirebaseRemoteConfigSettings(envLaunch.isEmpty ? env : envLaunch)
      .initialize();

  await envFirebaseMessageSettings(envLaunch.isEmpty ? env : envLaunch)
      .inicialize(
    callback: () =>
        envFirebaseRemoteConfigSettings(envLaunch.isEmpty ? env : envLaunch)
            .forceFetch(),
  );
  await envFirebaseMessageSettings(envLaunch.isEmpty ? env : envLaunch)
      .getTokenFirebase();

  runApp(
    AppModule(
      env: env,
      envLaunch: envLaunch,
      baseUrl: baseUrl,
      prefixo: prefixo,
    ),
  );
}

FirebaseMessageDataSource envFirebaseMessageSettings(String? env) {
  switch (env) {
    case 'hml':
      return FirebaseMessageRemoteDatasource.instance;

    default:
      return FirebaseMessageLocalDatasource.instance;
  }
}

FirebaseRemoteConfiguration envFirebaseRemoteConfigSettings(String? env) {
  switch (env) {
    case 'hml':
      return FirebaseRemoteConfigurationRemoteImpl.instance;

    default:
      return FirebaseRemoteConfigurationLocalImpl.instance;
  }
}
