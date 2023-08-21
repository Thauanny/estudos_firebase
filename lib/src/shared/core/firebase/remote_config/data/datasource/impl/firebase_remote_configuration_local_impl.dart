import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/firebase_remote_configurtion.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';

class FirebaseRemoteConfigurationLocalImpl
    implements FirebaseRemoteConfiguration {
  FirebaseRemoteConfigurationLocalImpl._singleton();

  static final FirebaseRemoteConfigurationLocalImpl _instance =
      FirebaseRemoteConfigurationLocalImpl._singleton();

  static FirebaseRemoteConfigurationLocalImpl get instance => _instance;

  @override
  Future<void> forceFetch() async {
    try {} on PlatformException catch (exception) {
      throw (exception.toString());
    } catch (exception) {
      throw ("Erro ao buscar dados remotamente");
    }
  }

  @override
  getValueOrDefault({required String key, required defaultValue}) {
    switch (defaultValue.runtimeType) {
      case String:
        return defaultValue;
      case int:
        return defaultValue;
      case bool:
        return defaultValue;
      case double:
        return defaultValue;
      default:
        Exception("Implementation not found");
    }
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> getFeatureRemote({required RemoteFeatureType type}) {
    // TODO: implement getFeatureRemote
    throw UnimplementedError();
  }
}
