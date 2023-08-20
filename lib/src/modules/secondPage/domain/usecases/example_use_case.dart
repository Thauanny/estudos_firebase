import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/usecase/usecase.dart';

class ExampleSecondPageUseCase implements UseCase<bool, NoParams> {
  @override
  Future<Either<Exception, bool>> call([NoParams? params]) async {
    return Right(true);
  }
}
