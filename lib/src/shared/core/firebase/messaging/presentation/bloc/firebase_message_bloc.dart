import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_message_event.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseMessageBloc
    extends Bloc<FirebaseMessageEvent, FirebaseMessageState> {
  FirebaseMessageBloc._singleton() : super(FirebaseMessageInitial()) {
    on(_onEvent);
  }

  static final FirebaseMessageBloc _instance = FirebaseMessageBloc._singleton();

  static FirebaseMessageBloc get instance => _instance;

  Future<void> _onEvent(
      FirebaseMessageEvent event, Emitter<FirebaseMessageState> emit) async {
    switch (event.runtimeType) {
      case FirebaseMessageEventReceived:
        _subscribeOnMessageFirebase(
          emit: emit,
        );
        break;

      case FirebaseMessageEventListenCancel:
        _subscribeOnMessageFirebaseCancel(
          emit: emit,
        );
        break;

      case FirebaseMessageEventOpenAppReceived:
        if (event is FirebaseMessageEventOpenAppReceived) {
          _subscribeOnMessageOpenAppFirebase(emit: emit, data: event.data);
        }
        break;
      case FirebaseMessageEventOpenAppCancel:
        _subscribeOnMessageOpenAppFirebaseCancel(
          emit: emit,
        );
        break;
      default:
    }
  }

  void _subscribeOnMessageFirebase({
    required Emitter<FirebaseMessageState> emit,
  }) async {
    // final result = await useCase();
    // result.fold(
    //   (l) => emit(FirebaseStateSubscribedOnMessageFirebaseError()),
    //   (r) => emit(FirebaseStateSubscribedOnMessageFirebaseSucess()),
    // );
  }

  void _subscribeOnMessageFirebaseCancel({
    required Emitter<FirebaseMessageState> emit,
  }) async {
    //await firebaseMessageDataSource.onMessageCancel();
  }

  void _subscribeOnMessageOpenAppFirebase(
      {required Emitter<FirebaseMessageState> emit,
      required Map<String, dynamic>? data}) async {
    if (data != null && data.isNotEmpty) {
      emit(FirebaseMessageOpenAppSucess(rota: data));
    } else {
      emit(FirebaseMessageOpenAppError());
    }
  }

  void _subscribeOnMessageOpenAppFirebaseCancel({
    required Emitter<FirebaseMessageState> emit,
  }) async {
    //await firebaseMessageDataSource.onMessageOpenedAppCancel();
  }
}
