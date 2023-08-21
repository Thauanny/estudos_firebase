import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/domain/entity/custom_remote_notification.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class FirebaseMessageLocalDatasource implements FirebaseMessageDataSource {
  FirebaseMessageLocalDatasource._singleton();

  static final FirebaseMessageLocalDatasource _instance =
      FirebaseMessageLocalDatasource._singleton();

  static FirebaseMessageDataSource get instance => _instance;

  @override
  Future<void> inicialize({VoidCallback? callback}) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    onMessageListen();
  }

  @override
  Future<void> onMessageCancel() async {}

  @override
  Future<void> onMessageOpenedAppCancel() async {}

  @override
  Future<void> onMessageListen() async {}

  @override
  getTokenFirebase() async => debugPrintHelper('local TOken');
}
