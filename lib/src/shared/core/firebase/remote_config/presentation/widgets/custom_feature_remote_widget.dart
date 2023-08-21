import 'package:flutter/widgets.dart';

import 'package:flutter_application_1/src/shared/core/firebase/remote_config/data/model/remote_feature_type.dart';
import 'package:flutter_application_1/src/shared/core/firebase/remote_config/presentation/controller/firebase_remote_config_controller.dart';
import 'package:get_it/get_it.dart';

class CustomFeatureRemoteWidget extends StatefulWidget {
  const CustomFeatureRemoteWidget({
    Key? key,
    required this.remoteFeatureType,
    this.onEnabled,
    this.onDisabled,
    this.onLoading,
    this.onFailure,
  }) : super(key: key);
  final RemoteFeatureType remoteFeatureType;
  final Widget? onEnabled;
  final Widget? onDisabled;
  final Widget? onLoading;
  final Widget? onFailure;

  @override
  State<CustomFeatureRemoteWidget> createState() =>
      _CustomFeatureRemoteWidgetState();
}

class _CustomFeatureRemoteWidgetState extends State<CustomFeatureRemoteWidget> {
  late final FirebaseRemoteConfigController firebaseController;
  @override
  void initState() {
    super.initState();

    firebaseController = GetIt.I.get<FirebaseRemoteConfigController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      initialData: true,
      future:
          firebaseController.getFeatureRemote(type: widget.remoteFeatureType),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading ?? const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return widget.onFailure ?? const SizedBox.shrink();
        } else if (snapshot.data ?? false) {
          return widget.onEnabled ?? const SizedBox.shrink();
        } else {
          return widget.onDisabled ?? const SizedBox.shrink();
        }
      },
    );
  }
}
