abstract class FirebaseMessageState {}

class FirebaseMessageInitial extends FirebaseMessageState {}

class FirebaseMessageExampleSucess extends FirebaseMessageState {}

class FirebaseMessageExampleError extends FirebaseMessageState {}

class FirebaseMessageSucess extends FirebaseMessageState {}

class FirebaseMessageError extends FirebaseMessageState {}

class FirebaseMessageOpenAppSucess extends FirebaseMessageState {
  final Map<String, dynamic>? rota;

  FirebaseMessageOpenAppSucess({required this.rota});
}

class FirebaseMessageOpenAppError extends FirebaseMessageState {}
