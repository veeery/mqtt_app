import 'package:get_it/get_it.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/datasource/mqtt_remote_data_source.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/repositories/mqtt_repository_impl.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/connect.dart';

import '../modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';

final locator = GetIt.instance;

void injectionMqtt() {
  // BloC
  locator.registerFactory(
    () => MqttBloc(
      connect: locator(),
    ),
  );

  // UseCase
  locator.registerLazySingleton(() => MqttUseCaseConnect(locator()));

  // Repository
  locator.registerLazySingleton<MqttRepository>(
    () => MqttRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<MqttRemoteDataSource>(() => MqttRemoteDataSourceImpl(client: locator()));
}