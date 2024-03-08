part of 'mqtt_bloc.dart';

abstract class MqttState extends Equatable {
  @override
  List<Object> get props => [];
}

class MqttInitial extends MqttState {}

class MqttConnected extends MqttState {
  final String message;
  final MqttModel mqttModel;

  MqttConnected({required this.message, required this.mqttModel});

  @override
  List<Object> get props => [message, mqttModel];
}

class MqttConnecting extends MqttState {
  final bool isLoading;

  MqttConnecting({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class MqttError extends MqttState {
  final String message;

  MqttError({required this.message});

  @override
  List<Object> get props => [message];
}
