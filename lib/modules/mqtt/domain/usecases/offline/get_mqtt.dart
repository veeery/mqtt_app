import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/core/common/failure.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';

import '../../repositories/mqtt_repository.dart';

class GetMqttCache {
  final MqttRepository repository;

  GetMqttCache(this.repository);

  Future<Either<Failure, MqttModel>> execute({required String username}) async {
    return await repository.getMqttDataByUsername(username: username);
  }
}
