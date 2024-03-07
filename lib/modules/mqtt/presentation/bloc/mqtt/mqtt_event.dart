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
