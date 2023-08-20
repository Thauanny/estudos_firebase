import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/modules/secondPage/data/datasources/impl/second_page_local_datasource.dart';
import 'package:flutter_application_1/src/modules/secondPage/data/datasources/impl/second_page_remote_datasource.dart';
import 'package:flutter_application_1/src/modules/secondPage/data/repository/second_page_repository_impl.dart';
import 'package:flutter_application_1/src/modules/secondPage/domain/repository/second_page_repository.dart';
import 'package:flutter_application_1/src/modules/secondPage/domain/usecases/example_use_case.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/network_settings/network_settings.dart';
import 'package:get_it/get_it.dart';

import 'presentation/pages/bloc/second_page_bloc.dart';

abstract class SecondPageModule<T extends StatefulWidget> extends State<T> {
  SecondPageModule() {
    //DATASOURCERS
    //local
    GetIt.I.registerSingleton<SecondPageLocalDataSource>(
      SecondPageLocalDataSource(),
    );
    //remote
    GetIt.I.registerSingleton<SecondPageRemoteDataSource>(
      SecondPageRemoteDataSource(),
    );

    //REPOSITORY
    GetIt.I.registerSingleton<SecondPageRepository>(
      SecondPageRepositoryImpl(
        settings: GetIt.I.get<NetworkSettings>(),
        secondPageLocalDataSource: GetIt.I.get<SecondPageLocalDataSource>(),
        secondPageRemoteDataSource: GetIt.I.get<SecondPageRemoteDataSource>(),
      ),
    );

    //USECASE
    GetIt.I.registerSingleton<ExampleSecondPageUseCase>(
      ExampleSecondPageUseCase(),
    );

    //BlOC
    GetIt.I.registerSingleton<SecondPageBloc>(
      SecondPageBloc(
        exampleUseCase: GetIt.I.get<ExampleSecondPageUseCase>(),
      ),
    );
  }
  @override
  void dispose() {
    GetIt.I.unregister<SecondPageLocalDataSource>();
    GetIt.I.unregister<SecondPageRemoteDataSource>();
    GetIt.I.unregister<SecondPageRepository>();
    GetIt.I.unregister<SecondPageBloc>();
    super.dispose();
  }
}
