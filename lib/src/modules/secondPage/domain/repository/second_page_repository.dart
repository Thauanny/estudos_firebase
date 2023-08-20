import 'package:dartz/dartz.dart';

abstract class SecondPageRepository {
  Future<Either<Exception, bool>> example();
}
