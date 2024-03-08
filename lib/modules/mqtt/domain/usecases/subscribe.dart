import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';

import '../../../core/common/failure.dart';

class MqttUseCaseSubscribe {
  final MqttRepository repository;

  MqttUseCaseSubscribe(this.repository);

  Future<Either<Failure, bool>> execute({required String topic}) {
    return repository.subscribeMqttRepository(topic: topic);
  }
}
