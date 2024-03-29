import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/common/failure.dart';

abstract class MqttRepository {
  // Remote
  Future<Either<Failure, MqttServerClient>> connectMqttRepository({required MqttModel mqttModel});
  Future<Either<Failure, MqttServerClient>> disconnectMqttRepository({required MqttModel mqttModel});
  Future<Either<Failure, bool>> subscribeMqttRepository({required String topic});
  Future<Either<Failure, bool>> unsubscribeMqttRepository({required String topic});
  Future<Either<Failure, bool>> sendMessageMqttRepository({required String topic, required String message});
  // Local
  Future<Either<Failure, MqttModel>> getMqttDataByUsername({required String username});
  Future<Either<Failure, bool>> deleteMqttDataByUsername({required String username});
  Future<Either<Failure, bool>> insertMqttData({required MqttModel mqttDataModel});

}