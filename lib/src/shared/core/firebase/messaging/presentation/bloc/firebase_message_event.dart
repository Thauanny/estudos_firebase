abstract class FirebaseMessageEvent {}

class FirebaseMessageEventExample extends FirebaseMessageEvent {}

class FirebaseMessageEventReceived extends FirebaseMessageEvent {}

class FirebaseMessageEventListenCancel extends FirebaseMessageEvent {}

class FirebaseMessageEventOpenAppReceived extends FirebaseMessageEvent {
  Map<String, dynamic>? data;
  FirebaseMessageEventOpenAppReceived({
    this.data,
  });
}

class FirebaseMessageEventOpenAppCancel extends FirebaseMessageEvent {}
