import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MemoryData {
  static MqttModel? mqttModel;
  static MqttConnectionState mqttStatus = MqttConnectionState.disconnected;
}
