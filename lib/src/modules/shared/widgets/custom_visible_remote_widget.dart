import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/firebase/firebase_remote_config/custom_remote_config.dart';

class CustomVisibleRemoteWidget extends StatelessWidget {
  final Widget child;
  final String remoteKey;
  final dynamic defaultValue;
  const CustomVisibleRemoteWidget({
    Key? key,
    required this.child,
    required this.remoteKey,
    required this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CustomRemoteConfig.instance.getValueOrDefault(
        key: remoteKey,
        defaultValue: defaultValue,
      ),
      child: child,
    );
  }
}
