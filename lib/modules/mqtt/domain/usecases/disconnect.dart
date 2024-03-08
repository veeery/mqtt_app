import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/common/failure.dart';
import '../../data/model/mqtt_model.dart';

class MqttUseCaseDisconnect {
  final MqttRepository repository;

  MqttUseCaseDisconnect(this.repository);

  Future<Either<Failure, MqttServerClient>> execute({required MqttModel mqttModel}) {
    return repository.disconnectMqttRepository(mqttModel: mqttModel);
  }
}
