import 'package:flutter/material.dart';

abstract class FirebaseMessageDataSource {
  Future<void> inicialize({VoidCallback? callback});
  Future<void> onMessageListen();
  dynamic getTokenFirebase();
  Future<void> onMessageCancel();
  Future<void> onMessageOpenedAppCancel();
}
