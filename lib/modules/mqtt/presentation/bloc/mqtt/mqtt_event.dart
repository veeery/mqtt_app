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

class DisconnectMqtt extends MqttEvent {
  final MqttModel mqttModel;

  const DisconnectMqtt({
    required this.mqttModel,
  });

  @override
  List<Object> get props => [mqttModel];
}

class SubscribeMqtt extends MqttEvent {
  final String topic;

  const SubscribeMqtt({
    required this.topic,
  });

  @override
  List<Object> get props => [topic];
}

class UnsubscribeMqtt extends MqttEvent {
  final String topic;

  const UnsubscribeMqtt({
    required this.topic,
  });

  @override
  List<Object> get props => [topic];
}

class SendMessageMqtt extends MqttEvent {
  final String message;
  final String topic;

  const SendMessageMqtt({
    required this.message,
    required this.topic,
  });

  @override
  List<Object> get props => [message, topic];
}

class LoadMessages extends MqttEvent {
  const LoadMessages();

  @override
  List<Object> get props => [];
}

class GetMqttCacheEvent extends MqttEvent {
  final String username;

  const GetMqttCacheEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}
