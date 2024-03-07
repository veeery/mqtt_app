import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class MqttRemoteDataSource {
  Future<MqttServerClient> connect({required MqttModel mqttModel});
}

class MqttRemoteDataSourceImpl implements MqttRemoteDataSource {
  // final http.Client client;
  MqttServerClient? client;

  MqttRemoteDataSourceImpl();

  @override
  Future<MqttServerClient> connect({required MqttModel mqttModel}) async {
    client = MqttServerClient.withPort(
      mqttModel.host,
      "flutter_client",
      int.parse(mqttModel.port),
    );

    try {
      // Set up the client with the provided parameters
      // ...
      await client!.connect();
      return client!;
    } catch (e) {
      print('Exception: $e');
      client!.disconnect();
      throw Exception();
    }
  }
}
