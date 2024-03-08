import 'package:get_it/get_it.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/datasource/mqtt_remote_data_source.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/repositories/mqtt_repository_impl.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/connect.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/disconnect.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/delete_mqtt.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/get_mqtt.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/insert_mqtt.dart';

import '../modules/mqtt/data/datasource/mqtt_local_data_source.dart';
import '../modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';

final locator = GetIt.instance;

void injectionMqtt() {
  // locator.registerLazySingleton(() => MqttServerClient.withPort('broker.emqx.io', "flutter_client", 1883));

  // BloC
  locator.registerFactory(
    () => MqttBloc(
      connect: locator(),
      disconnect: locator(),
      getMqttCache: locator(),
      insertCache: locator(),
      deleteCache: locator(),
    ),
  );

  // UseCase
  locator.registerLazySingleton(() => MqttUseCaseConnect(locator()));
  locator.registerLazySingleton(() => MqttUseCaseDisconnect(locator()));

  locator.registerLazySingleton(() => GetMqttCache(locator()));
  locator.registerLazySingleton(() => InsertMqtt(locator()));
  locator.registerLazySingleton(() => DeleteMqtt(locator()));

  // Repository
  locator.registerLazySingleton<MqttRepository>(
    () => MqttRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data Source
  locator.registerLazySingleton<MqttRemoteDataSource>(() => MqttRemoteDataSourceImpl());
  locator.registerLazySingleton<MqttLocalDataSource>(() => MqttLocalDataSourceImpl(databaseHelper: locator()));
}
