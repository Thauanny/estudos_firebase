import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/src/modules/secondPage/data/datasources/impl/second_page_local_datasource.dart';
import 'package:flutter_application_1/src/modules/secondPage/data/datasources/impl/second_page_remote_datasource.dart';
import 'package:flutter_application_1/src/modules/secondPage/domain/repository/second_page_repository.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';

class SecondPageRepositoryImpl implements SecondPageRepository {
  final NetworkSettings settings;
  final SecondPageLocalDataSource secondPageLocalDataSource;
  final SecondPageRemoteDataSource secondPageRemoteDataSource;

  SecondPageRepositoryImpl({
    required this.settings,
    required this.secondPageLocalDataSource,
    required this.secondPageRemoteDataSource,
  });

  @override
  Future<Either<Exception, bool>> example() async {
    return await settings.selectRepository(
      local: () {
        return secondPageLocalDataSource.example();
      },
      remote: () {
        return secondPageRemoteDataSource.example();
      },
    );
  }
}
