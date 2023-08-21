import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/home_module.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/bloc/home_bloc.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/bloc/home_state.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_message_bloc.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_state.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/presentation/controller/firebase_remote_config_controller.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/presentation/widgets/custom_feature_remote_widget.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeModule<HomePage> {
  late final HomeBloc homeBloc;
  late StreamSubscription homeSubscription;
  late StreamSubscription firebaseSubscription;
  late final FirebaseMessageBloc firebaseMessagebloc;
  late final FirebaseRemoteConfigController firebaseRemoteController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    homeBloc = GetIt.I.get<HomeBloc>();
    firebaseMessagebloc = GetIt.I.get<FirebaseMessageBloc>();
    firebaseRemoteController = GetIt.I.get<FirebaseRemoteConfigController>();
    firebaseSubscription = firebaseMessagebloc.stream.listen(onListenFirebase);
    homeSubscription = homeBloc.stream.listen(onListen);
  }

  _update() {
    setState(() {
      _isLoading = true;
    });
    firebaseRemoteController.forceFetch();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firebaseRemoteController.getValueOrDefault(
                type: RemoteFeatureType.blueappbar, defaultValue: false)
            ? Colors.blue
            : Colors.red,
        title: const Text('Home'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    firebaseRemoteController
                        .getValueOrDefault(
                          type: RemoteFeatureType.remotestring,
                          defaultValue: 'Local',
                        )
                        .toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                CustomFeatureRemoteWidget(
                  remoteFeatureType: RemoteFeatureType.showcontainer,
                  onEnabled: Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  ),
                  onLoading: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _update();
        },
        tooltip: 'reload',
        child: const Icon(Icons.replay_outlined),
      ),
    );
  }

  void onListen(HomeState state) {
    switch (state.runtimeType) {
      default:
    }
  }

  void onListenFirebase(FirebaseMessageState state) {
    switch (state.runtimeType) {
      case FirebaseMessageOpenAppSucess:
        if (state is FirebaseMessageOpenAppSucess) {
          Navigator.pushNamed(context, state.rota?['secondPage']);
        }
        break;
      default:
    }
  }
}
