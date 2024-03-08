import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';

import '../../../core/common/failure.dart';

class MqttUseCaseSendMessage {
  final MqttRepository repository;

  MqttUseCaseSendMessage(this.repository);

  Future<Either<Failure, bool>> execute({required String topic, required String message}) {
    return repository.sendMessageMqttRepository(topic: topic, message: message);
  }
}
