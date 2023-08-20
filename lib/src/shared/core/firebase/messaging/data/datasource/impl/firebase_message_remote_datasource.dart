import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/domain/entity/custom_remote_notification.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_bloc.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_event.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'firebase_custom_local_notificaton.dart';

class FirebaseMessageRemoteDatasource implements FirebaseMessageDataSource {
  FirebaseMessageRemoteDatasource._singleton(this.bloc);

  static final FirebaseMessageRemoteDatasource _instance =
      FirebaseMessageRemoteDatasource._singleton(
    FirebaseBloc.instance,
  );

  late StreamSubscription<RemoteMessage> streamSubscriptionMessage;
  late StreamSubscription<RemoteMessage> streamSubscriptionMessageOpenedApp;
  CustomRemoteNotification? customRemoteNotification;
  FirebaseCustomLocalNotification? _localNotification;

  static FirebaseMessageDataSource get instance => _instance;

  final FirebaseBloc bloc;

  @override
  Future<void> inicialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    _localNotification = FirebaseCustomLocalNotification.instance;

    onMessageListen();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      bloc.add(
        FirebaseEventSubscribeOnMessageOpenAppFirebase(data: message.data),
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
  Future<void> onMessageListen() async {
    streamSubscriptionMessage =
        FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;

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
