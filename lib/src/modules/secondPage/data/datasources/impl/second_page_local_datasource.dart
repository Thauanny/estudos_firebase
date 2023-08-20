import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/modules/home/data/datasources/home_datasource.dart';
import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class SecondPageLocalDataSource implements HomeDataSource {
  @override
  Future<Either<Exception, bool>> example() async {
    try {
      debugPrintHelper("local");
      return const Right(true);
    } catch (e) {
      return Left(Exception());
    }
  }
}
