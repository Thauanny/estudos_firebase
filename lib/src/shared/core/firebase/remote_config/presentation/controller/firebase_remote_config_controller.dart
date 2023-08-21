import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/datasource/impl/firebase_remote_configuration_remote_impl.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';

class FirebaseRemoteConfigController {
  //todo :chamar use case
  final FirebaseRemoteConfigurationRemoteImpl remote;
  FirebaseRemoteConfigController({
    required this.remote,
  });

  Future<bool> getFeatureRemote({required RemoteFeatureType type}) async {
    return await remote.getFeatureRemote(type: type);
  }

  Future<void> forceFetch() async {
    await remote.forceFetch();
  }

  dynamic getValueOrDefault(
      {required RemoteFeatureType type, required dynamic defaultValue}) {
    return remote.getValueOrDefault(
      key: type.name,
      defaultValue: defaultValue,
    );
  }
}
