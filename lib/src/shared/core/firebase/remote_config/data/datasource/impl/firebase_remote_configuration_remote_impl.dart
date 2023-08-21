import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/firebase_remote_configurtion.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';

class FirebaseRemoteConfigurationRemoteImpl
    implements FirebaseRemoteConfiguration {
  late FirebaseRemoteConfig _firebaseRemoteConfig;

  FirebaseRemoteConfigurationRemoteImpl._singleton();

  static final FirebaseRemoteConfigurationRemoteImpl _instance =
      FirebaseRemoteConfigurationRemoteImpl._singleton();

  static FirebaseRemoteConfigurationRemoteImpl get instance => _instance;

  @override
  Future<void> forceFetch() async {
    try {
      await _firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await _firebaseRemoteConfig.fetchAndActivate();
    } on PlatformException catch (exception) {
      throw (exception.toString());
    } catch (exception) {
      throw ("Erro ao buscar dados remotamente");
    }
  }

  @override
  getValueOrDefault({required String key, required defaultValue}) {
    switch (defaultValue.runtimeType) {
      case String:
        var value = _firebaseRemoteConfig.getString(key);
        return value != '' ? value : defaultValue;
      case int:
        var value = _firebaseRemoteConfig.getInt(key);
        return value != 0 ? value : defaultValue;

      case bool:
        var value = _firebaseRemoteConfig.getBool(key);
        return value != false ? value : defaultValue;
      case double:
        var value = _firebaseRemoteConfig.getDouble(key);
        return value != 0.0 ? value : defaultValue;

      default:
        Exception("Implementation not found");
    }
  }

  @override
  Future<bool> getFeatureRemote({required RemoteFeatureType type}) async {
    await Future.delayed(const Duration(microseconds: 0));
    return _firebaseRemoteConfig.getBool(type.name);
  }

  @override
  Future<void> initialize() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
  }
}
