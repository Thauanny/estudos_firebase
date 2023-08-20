abstract class FirebaseEvent {}

class FirebaseEventExample extends FirebaseEvent {}

class FirebaseEventSubscribeOnMessageFirebase extends FirebaseEvent {}

class FirebaseEventSubscribeOnMessageFirebaseCancel extends FirebaseEvent {}

class FirebaseEventSubscribeOnMessageOpenAppFirebase extends FirebaseEvent {
  Map<String, dynamic>? data;
  FirebaseEventSubscribeOnMessageOpenAppFirebase({
    this.data,
  });
}

class FirebaseEventSubscribeOnMessageOpenAppFirebaseCancel
    extends FirebaseEvent {}
