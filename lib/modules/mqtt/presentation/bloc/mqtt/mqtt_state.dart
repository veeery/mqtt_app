part of 'mqtt_bloc.dart';

abstract class MqttState extends Equatable {
  @override
  List<Object> get props => [];
}

class MqttInitial extends MqttState {}

class MqttEmpty extends MqttState {}

// Connect
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

// Disconnect
class MqttDisconnecting extends MqttState {
  final bool isLoading;

  MqttDisconnecting({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class MqttDisconnected extends MqttState {
  final String message;
  final MqttModel mqttModel;

  MqttDisconnected({required this.message, required this.mqttModel});

  @override
  List<Object> get props => [message, mqttModel];
}

// Subscribe
class MqttSubscribing extends MqttState {
  final bool isLoading;

  MqttSubscribing({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class MqttSubscribed extends MqttState {
  final String topic;

  MqttSubscribed({required this.topic});

  @override
  List<Object> get props => [topic];
}

// Unsubscribe
class MqttUnsubscribing extends MqttState {
  final bool isLoading;

  MqttUnsubscribing({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class MqttUnsubscribed extends MqttState {
  final String topic;

  MqttUnsubscribed({required this.topic});

  @override
  List<Object> get props => [topic];
}

// Publish / Message

class MqttMessageSending extends MqttState {
  final bool isLoading;

  MqttMessageSending({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class MqttMessageSent extends MqttState {
  final String topic;
  final String message;

  MqttMessageSent({required this.topic, required this.message});

  @override
  List<Object> get props => [topic, message];
}

class MqttMessageReceived extends MqttState {
  final String message;

  MqttMessageReceived({required this.message});

  @override
  List<Object> get props => [message];
}

class MqttError extends MqttState {
  final String message;

  MqttError({required this.message});

  @override
  List<Object> get props => [message];
}
