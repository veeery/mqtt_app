import 'package:get_it/get_it.dart';
import 'package:mqtt_broker_app/injection_library/injection_mqtt.dart';

import 'modules/core/data/db/database_helper.dart';

final locator = GetIt.instance;

void init() {

  // Database Helper / SQLite
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // MQTT
  injectionMqtt();
}