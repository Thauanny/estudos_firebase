import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/domain/entity/custom_remote_notification.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_message_bloc.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_message_event.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'firebase_custom_local_notificaton.dart';

class FirebaseMessageRemoteDatasource implements FirebaseMessageDataSource {
  FirebaseMessageRemoteDatasource._singleton(this.bloc);

  static final FirebaseMessageRemoteDatasource _instance =
      FirebaseMessageRemoteDatasource._singleton(
    FirebaseMessageBloc.instance,
  );

  late StreamSubscription<RemoteMessage> streamSubscriptionMessage;
  late StreamSubscription<RemoteMessage> streamSubscriptionMessageOpenedApp;
  CustomRemoteNotification? customRemoteNotification;
  FirebaseCustomLocalNotification? _localNotification;

  static FirebaseMessageDataSource get instance => _instance;

  final FirebaseMessageBloc bloc;

  @override
  Future<void> inicialize({VoidCallback? callback}) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    _localNotification = FirebaseCustomLocalNotification.instance;

    onMessageListen(callback: callback);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['forceFetch'] != null) callback?.call();
      bloc.add(
        FirebaseMessageEventOpenAppReceived(data: message.data),
      );
    });
  }

  @override
  Future<void> onMessageCancel() async {
    await streamSubscriptionMessage.cancel();
  }

  @override
  Future<void> onMessageOpenedAppCancel() async {
    await streamSubscriptionMessageOpenedApp.cancel();
  }

  @override
  Future<void> onMessageListen({VoidCallback? callback}) async {
    streamSubscriptionMessage =
        FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;

      if (message.data['forceFetch'] != null) {
        callback?.call();
        return;
      }

      if (_localNotification != null &&
          notification != null &&
          notification.android != null &&
          !kIsWeb) {
        _localNotification?.androidNotification(
          notification: notification,
          android: notification.android!,
        );

        customRemoteNotification = CustomRemoteNotification(
          body: notification.body,
          title: notification.title,
        );
      } else if (notification != null && kIsWeb) {
        customRemoteNotification = CustomRemoteNotification(
          body: notification.body,
          title: notification.title,
        );
      }
    });
  }

  @override
  getTokenFirebase() async =>
      debugPrintHelper(await FirebaseMessaging.instance.getToken() ?? '');
}
