import 'dart:async';
import 'dart:io';

import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/common/exception.dart';

abstract class MqttRemoteDataSource {
  Future<MqttServerClient> connect({required MqttModel mqttModel});
}

class MqttRemoteDataSourceImpl implements MqttRemoteDataSource {
  // final http.Client client;
  MqttServerClient? client;

  MqttRemoteDataSourceImpl();

  @override
  Future<MqttServerClient> connect({required MqttModel mqttModel}) async {
    try {
      client = MqttServerClient.withPort(
        mqttModel.host,
        // "broker.emqx.io",
        "flutter_client",
        // 1883
        mqttModel.port,
      );

      await client?.connect();
      return client!;
    } catch (e) {
      print('Exception: $e');
      client?.disconnect();

      if (e is SocketException) {
        throw SocketException("Failed to connect: $e");
      } else if (e is TimeoutException) {
        throw TimeoutException('Timeout: $e');
      } else {
        throw ServerException();
      }
    }
  }
}
