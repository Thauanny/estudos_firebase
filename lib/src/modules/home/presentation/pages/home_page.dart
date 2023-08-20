import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/home/home_module.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/bloc/home_bloc.dart';
import 'package:flutter_application_1/src/modules/home/presentation/pages/bloc/home_state.dart';
import 'package:flutter_application_1/src/modules/shared/widgets/custom_visible_remote_widget.dart';
import 'package:flutter_application_1/src/shared/core/firebase/firebase_remote_config/custom_remote_config.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_bloc.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_state.dart';
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
  late final FirebaseBloc firebasebloc;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    homeBloc = GetIt.I.get<HomeBloc>();
    firebasebloc = GetIt.I.get<FirebaseBloc>();
    firebaseSubscription = firebasebloc.stream.listen(onListenFirebase);
    homeSubscription = homeBloc.stream.listen(onListen);
  }

  _increment() async {
    setState(() {
      _isLoading = true;
    });
    await CustomRemoteConfig.instance.forceFetch();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomRemoteConfig.instance
                .getValueOrDefault(key: 'isActiveBlue', defaultValue: false)
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
                    CustomRemoteConfig.instance
                        .getValueOrDefault(
                          key: 'novaString',
                          defaultValue: 'Local',
                        )
                        .toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                CustomVisibleRemoteWidget(
                  remoteKey: 'showContainer',
                  defaultValue: false,
                  child: Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _increment();
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

  void onListenFirebase(FirebaseState state) {
    switch (state.runtimeType) {
      case FirebaseStateSubscribedOnMessageOpenAppFirebaseSucess:
        if (state is FirebaseStateSubscribedOnMessageOpenAppFirebaseSucess) {
          Navigator.pushNamed(context, state.rota?['secondPage']);
        }
        break;
      default:
    }
  }
}
