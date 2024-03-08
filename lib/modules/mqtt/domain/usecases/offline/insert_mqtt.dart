import 'package:dartz/dartz.dart';

import '../../../../core/common/failure.dart';
import '../../../data/model/mqtt_model.dart';
import '../../repositories/mqtt_repository.dart';

class InsertMqtt {
  final MqttRepository repository;

  InsertMqtt(this.repository);

  Future<Either<Failure, bool>> execute({required MqttModel mqttModel}) {
    return repository.insertMqttData(mqttDataModel: mqttModel);
  }
}
