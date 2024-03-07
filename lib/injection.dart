import 'package:get_it/get_it.dart';
import 'package:mqtt_broker_app/injection_library/injection_mqtt.dart';

final locator = GetIt.instance;

void init() {

  // Database Helper / SQLite
  // locator.registerLazySingleton(() => DatabaseHelper());

  // MQTT
  injectionMqtt();
}