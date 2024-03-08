import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';

import '../../../core/common/failure.dart';

class MqttUseCaseUnsubscribe {
  final MqttRepository repository;

  MqttUseCaseUnsubscribe(this.repository);

  Future<Either<Failure, bool>> execute({required String topic}) {
    return repository.unsubscribeMqttRepository(topic: topic);
  }
}
