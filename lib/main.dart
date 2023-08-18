import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_module.dart';
import 'package:flutter_application_1/src/shared/core/environment/env_variables/env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    AppModule(
      env: Env.get("ENV"),
      envLaunch: Env.get("ENV_LAUNCH"),
      baseUrl: Env.get("BASE_URL"),
      prefixo: Env.get("PREFIXO"),
    ),
  );
}
