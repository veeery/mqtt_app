import 'dart:async';
import 'dart:io';

import 'package:mqtt_broker_app/modules/core/common/get_device_info.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/common/exception.dart';

abstract class MqttRemoteDataSource {
  Future<MqttServerClient> connect({required MqttModel mqttModel});

  Future<MqttServerClient> disconnect({required MqttModel mqttModel});

  Future<bool> subscribe({required String topic});

  Future<bool> unsubscribe({required String topic});

  Future<bool> message({required String topic, required String message});
}

class MqttRemoteDataSourceImpl implements MqttRemoteDataSource {
  // final http.Client client;
  MqttServerClient? client;

  MqttRemoteDataSourceImpl();

  @override
  Future<MqttServerClient> connect({required MqttModel mqttModel}) async {
    String id = await getDeviceId();

    try {
      client = MqttServerClient.withPort(
        mqttModel.host,
        id,
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

  @override
  Future<MqttServerClient> disconnect({required MqttModel mqttModel}) async {

    String id = await getDeviceId();

    try {
      client = MqttServerClient.withPort(
        mqttModel.host,
        id,
        mqttModel.port,
      );
      client?.disconnect();
      print('Disconnected from MQTT broker.');
      return client!;
    } catch (e) {
      print('Exception: $e');
      // client?.disconnect();

      if (e is SocketException) {
        throw SocketException("Failed to connect: $e");
      } else if (e is TimeoutException) {
        throw TimeoutException('Timeout: $e');
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<bool> subscribe({required String topic}) async {
    bool isSubscribed = false;
    try {
      if (client?.connectionStatus?.state == MqttConnectionState.connected) {
        print('Subscribing to topic $topic');
        client!.subscribe(topic, MqttQos.atLeastOnce);
        isSubscribed = true;
      } else {
        print('Client is not connected, cannot subscribe to topic');
      }
    } catch (e) {
      print('Exception: $e');

      if (e is SocketException) {
        throw SocketException("Failed to subscribe: $e");
      } else if (e is TimeoutException) {
        throw TimeoutException('Timeout: $e');
      } else {
        throw ServerException();
      }
    }

    return isSubscribed;
  }

  @override
  Future<bool> unsubscribe({required String topic}) async {
    bool isUnsubscribed = false;
    try {
      if (client?.connectionStatus?.state == MqttConnectionState.connected) {
        print('Unsubscribing from topic $topic');
        client!.unsubscribe(topic);
        isUnsubscribed = true;
        print('Successfully unsubscribed from $topic');
      } else {
        print('Client is not connected, cannot unsubscribe from topic');
      }
    } catch (e) {
      print('Exception: $e');

      if (e is SocketException) {
        throw SocketException("Failed to unsubscribe: $e");
      } else if (e is TimeoutException) {
        throw TimeoutException('Timeout: $e');
      } else {
        throw ServerException();
      }
    }
    return isUnsubscribed;
  }

  @override
  Future<bool> message({required String topic, required String message}) async {
    bool isMessageSent = false;
    try {
      if (client?.connectionStatus?.state == MqttConnectionState.connected) {
        final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
        builder.addString(message);
        client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
        isMessageSent = true;
        print('Message sent to $topic: $message');
      } else {
        print('Client is not connected, cannot send message to topic');
      }
    } catch (e) {
      print('Exception: $e');

      if (e is SocketException) {
        throw SocketException("Failed to send message: $e");
      } else if (e is TimeoutException) {
        throw TimeoutException('Timeout: $e');
      } else {
        throw ServerException();
      }
    }

    return isMessageSent;
  }
}
