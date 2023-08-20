abstract class FirebaseState {}

class FirebaseInitial extends FirebaseState {}

class FirebaseExampleSucess extends FirebaseState {}

class FirebaseExampleError extends FirebaseState {}

class FirebaseStateSubscribedOnMessageFirebaseSucess extends FirebaseState {}

class FirebaseStateSubscribedOnMessageFirebaseError extends FirebaseState {}

class FirebaseStateSubscribedOnMessageOpenAppFirebaseSucess
    extends FirebaseState {
  final Map<String, dynamic>? rota;

  FirebaseStateSubscribedOnMessageOpenAppFirebaseSucess({required this.rota});
}

class FirebaseStateSubscribedOnMessageOpenAppFirebaseError
    extends FirebaseState {}
