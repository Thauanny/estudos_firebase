import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http_impl.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';
import 'package:flutter_application_1/src/shared/core/environment/routers/routers.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_message_bloc.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/impl/firebase_remote_configuration_local_impl.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/impl/firebase_remote_configuration_remote_impl.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/presentation/controller/firebase_remote_config_controller.dart';
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

    GetIt.I.registerSingleton<FirebaseMessageBloc>(
      FirebaseMessageBloc.instance,
    );

    GetIt.I.registerSingleton<FirebaseRemoteConfigurationRemoteImpl>(
      FirebaseRemoteConfigurationRemoteImpl.instance,
    );

    GetIt.I.registerSingleton<FirebaseRemoteConfigurationLocalImpl>(
      FirebaseRemoteConfigurationLocalImpl.instance,
    );

    GetIt.I.registerSingleton<FirebaseRemoteConfigController>(
      FirebaseRemoteConfigController(
        remote: GetIt.I.get<FirebaseRemoteConfigurationRemoteImpl>(),
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

//todo fazer use case e repository em remote config firebase
  @override
  void dispose() {
    GetIt.I.unregister<ClientHttp>();
    GetIt.I.unregister<NetworkSettings>();
    GetIt.I.unregister<FirebaseRemoteConfigurationRemoteImpl>();
    GetIt.I.unregister<FirebaseMessageBloc>();
    GetIt.I.unregister<FirebaseRemoteConfigurationLocalImpl>();
    GetIt.I.unregister<FirebaseRemoteConfigController>();
    super.dispose();
  }
}
