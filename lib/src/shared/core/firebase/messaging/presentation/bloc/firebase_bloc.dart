import 'package:flutter_application_1/src/shared/core/firebase/messaging/data/datasource/firebase_message_datasource.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_event.dart';
import 'package:flutter_application_1/src/shared/core/firebase/messaging/presentation/bloc/firebase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc._singleton() : super(FirebaseInitial()) {
    on(_onEvent);
  }

  static final FirebaseBloc _instance = FirebaseBloc._singleton();

  static FirebaseBloc get instance => _instance;

  Future<void> _onEvent(
      FirebaseEvent event, Emitter<FirebaseState> emit) async {
    switch (event.runtimeType) {
      case FirebaseEventSubscribeOnMessageFirebase:
        _subscribeOnMessageFirebase(
          emit: emit,
        );
        break;

      case FirebaseEventSubscribeOnMessageFirebaseCancel:
        _subscribeOnMessageFirebaseCancel(
          emit: emit,
        );
        break;

      case FirebaseEventSubscribeOnMessageOpenAppFirebase:
        if (event is FirebaseEventSubscribeOnMessageOpenAppFirebase) {
          _subscribeOnMessageOpenAppFirebase(emit: emit, data: event.data);
        }
        break;
      case FirebaseEventSubscribeOnMessageOpenAppFirebaseCancel:
        _subscribeOnMessageOpenAppFirebaseCancel(
          emit: emit,
        );
        break;
      default:
    }
  }

  void _subscribeOnMessageFirebase({
    required Emitter<FirebaseState> emit,
  }) async {
    // final result = await useCase();
    // result.fold(
    //   (l) => emit(FirebaseStateSubscribedOnMessageFirebaseError()),
    //   (r) => emit(FirebaseStateSubscribedOnMessageFirebaseSucess()),
    // );
  }

  void _subscribeOnMessageFirebaseCancel({
    required Emitter<FirebaseState> emit,
  }) async {
    //await firebaseMessageDataSource.onMessageCancel();
  }

  void _subscribeOnMessageOpenAppFirebase(
      {required Emitter<FirebaseState> emit,
      required Map<String, dynamic>? data}) async {
    if (data != null && data.isNotEmpty) {
      emit(FirebaseStateSubscribedOnMessageOpenAppFirebaseSucess(rota: data));
    } else {
      emit(FirebaseStateSubscribedOnMessageOpenAppFirebaseError());
    }
  }

  void _subscribeOnMessageOpenAppFirebaseCancel({
    required Emitter<FirebaseState> emit,
  }) async {
    //await firebaseMessageDataSource.onMessageOpenedAppCancel();
  }
}
