import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class MqttRemoteDataSource {
  Future<MqttServerClient> connect({required MqttModel mqttModel});
}

class MqttRemoteDataSourceImpl implements MqttRemoteDataSource {
  // final http.Client client;
  final MqttServerClient client;

  MqttRemoteDataSourceImpl({required this.client});

  @override
  Future<MqttServerClient> connect({required MqttModel mqttModel}) async {
    try {
      // Set up the client with the provided parameters
      // ...
      await client.connect();
      return client;
    } catch (e) {
      throw Exception();
    }
  }
}
