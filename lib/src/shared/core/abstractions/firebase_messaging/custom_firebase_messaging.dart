import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/firebase_messaging/custom_local_notification.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;
  static final CustomFirebaseMessaging _instance =
      CustomFirebaseMessaging._singleton(CustomLocalNotification.instance);

  CustomFirebaseMessaging._singleton(this._customLocalNotification);

  static CustomFirebaseMessaging get instance => _instance;

  Future<void> inicialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _customLocalNotification.androidNotification(
          notification: notification,
          android: android,
        );
      }

      //TODO verificar como fazer isso sem navigatorKey Global
      // FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //   navigatiorKey.currentState?.pushNamed(message.data['goTO']);
      // });
    });
  }

  getTokenFirebase() async =>
      debugPrintHelper(await FirebaseMessaging.instance.getToken() ?? '');
}
