import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/core/common/failure.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/datasource/mqtt_remote_data_source.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttRepositoryImpl implements MqttRepository {
  final MqttRemoteDataSource remoteDataSource;

  MqttRepositoryImpl({
    required this.remoteDataSource,
  });


  // ------ Remote -----
  @override
  Future<Either<Failure, MqttServerClient>> connectMqttRepository({required MqttModel mqttModel}) async {
    try {
      final client = await remoteDataSource.connect(mqttModel: mqttModel);
      return Right(client);
    } catch (e) {
      print('Failed to connect: $e');
      return Left(ServerFailure());
    }
  }

}
