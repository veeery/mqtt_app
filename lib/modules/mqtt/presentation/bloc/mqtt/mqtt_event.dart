part of 'mqtt_bloc.dart';

abstract class MqttEvent extends Equatable {
  const MqttEvent();
}

class ConnectMqtt extends MqttEvent {
  final MqttModel mqttModel;

  const ConnectMqtt({
    required this.mqttModel,
  });

  @override
  List<Object> get props => [mqttModel];
}

class GetMqttCacheEvent extends MqttEvent {
  final String username;

  const GetMqttCacheEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}
