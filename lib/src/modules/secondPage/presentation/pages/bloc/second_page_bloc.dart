import 'package:flutter_application_1/src/modules/secondPage/domain/usecases/example_use_case.dart';
import 'package:flutter_application_1/src/modules/secondPage/presentation/pages/bloc/second_page_event.dart';
import 'package:flutter_application_1/src/modules/secondPage/presentation/pages/bloc/second_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPageBloc extends Bloc<SecondPageEvent, SecondPageState> {
  SecondPageBloc({
    required this.exampleUseCase,
  }) : super(SecondPageInitial()) {
    on(_onEvent);
  }

  final ExampleSecondPageUseCase exampleUseCase;

  Future<void> _onEvent(
      SecondPageEvent event, Emitter<SecondPageState> emit) async {
    switch (event.runtimeType) {
      case SecondPageEventExample:
        _example(emit: emit, useCase: exampleUseCase);
        break;

      default:
    }
  }

  void _example({
    required Emitter<SecondPageState> emit,
    required ExampleSecondPageUseCase useCase,
  }) async {
    final result = await useCase();
    result.fold(
      (l) => emit(SecondPageExampleError()),
      (r) => emit(SecondPageExampleSucess()),
    );
  }
}
