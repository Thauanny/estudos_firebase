abstract class FirebaseMessageDataSource {
  Future<void> inicialize();
  Future<void> onMessageListen();
  dynamic getTokenFirebase();
  Future<void> onMessageCancel();
  Future<void> onMessageOpenedAppCancel();
}
