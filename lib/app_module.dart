import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http_impl.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';
import 'package:flutter_application_1/src/shared/core/environment/routers/routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

class AppModule extends StatefulWidget {
  final String env;
  final String envLaunch;
  final String baseUrl;
  final String prefixo;

  AppModule({
    super.key,
    required this.env,
    required this.envLaunch,
    required this.baseUrl,
    required this.prefixo,
  }) {
    GetIt.I.registerSingleton<NetworkSettings>(
      _networkSettings(envLaunch.isEmpty ? env : envLaunch),
    );
    GetIt.I.registerSingleton<ClientHttp>(
      ClienteHttpImpl(
        clienteHttp: Dio(),
        baseUrl: baseUrl,
        prefixo: prefixo,
      ),
    );
  }

  NetworkSettings _networkSettings(String? env) {
    switch (env) {
      case 'hml':
        return HmlSettingsNetwork();

      default:
        return DevSettingsNetwork();
    }
  }

  @override
  State<AppModule> createState() => _AppModuleState();
}

class _AppModuleState extends State<AppModule> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Teste",
      routes: routers,
      initialRoute: '/home',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ClientHttp>();
    GetIt.I.unregister<NetworkSettings>();
    super.dispose();
  }
}
