import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../repositories/mqtt_repository.dart';

class DeleteMqtt {
  final MqttRepository repository;

  DeleteMqtt(this.repository);

  Future<Either<Failure, bool>> execute({required String username}) {
    return repository.deleteMqttDataByUsername(username: username);
  }
}
