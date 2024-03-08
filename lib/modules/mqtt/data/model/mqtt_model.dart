import 'package:equatable/equatable.dart';

class MqttModel extends Equatable {
  final String host;
  final int port;
  final String username;
  final String password;

  const MqttModel({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [host, port, username, password];

  factory MqttModel.fromJson(Map<String, dynamic> json) {
    return MqttModel(
      host: json['host'],
      port: json['port'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'username': username,
      'password': password,
    };
  }
}
