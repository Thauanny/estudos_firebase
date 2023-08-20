part of 'firebase_message_remote_datasource.dart';

class FirebaseCustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;

  static final FirebaseCustomLocalNotification _instance =
      FirebaseCustomLocalNotification._singleton();

  FirebaseCustomLocalNotification._singleton() {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for importante notifications.',
      importance: Importance.max,
    );

    _configuraAndroid().then(
      (value) {
        flutterLocalNotificationsPlugin = value;
        inicializeNotifications();
      },
    );
  }

  Future<FlutterLocalNotificationsPlugin> _configuraAndroid() async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    return flutterLocalNotificationsPlugin;
  }

  inicializeNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  androidNotification({
    required RemoteNotification notification,
    required AndroidNotification android,
  }) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android.smallIcon,
        ),
      ),
    );
  }

  static FirebaseCustomLocalNotification get instance => _instance;
}
