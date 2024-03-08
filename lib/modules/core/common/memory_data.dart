import 'package:mqtt_broker_app/modules/core/common/state_enum.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MemoryData {
  static MqttModel? mqttModel;
  static MqttConnectionState mqttStatus = MqttConnectionState.disconnected;
  static MqttStatusState mqttStatusState = MqttStatusState.none;
  static MqttServerClient? client;
}
