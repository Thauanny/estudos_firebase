import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';

abstract class FirebaseRemoteConfiguration {
  Future<void> initialize();
  Future<void> forceFetch();
  getValueOrDefault({
    required String key,
    required dynamic defaultValue,
  });
  Future<bool> getFeatureRemote({required RemoteFeatureType type});
}
