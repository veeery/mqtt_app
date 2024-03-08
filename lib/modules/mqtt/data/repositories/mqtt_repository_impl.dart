import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mqtt_broker_app/modules/core/common/constant.dart';
import 'package:mqtt_broker_app/modules/core/common/failure.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/datasource/mqtt_remote_data_source.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/repositories/mqtt_repository.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/common/exception.dart';
import '../datasource/mqtt_local_data_source.dart';

class MqttRepositoryImpl implements MqttRepository {
  final MqttRemoteDataSource remoteDataSource;
  final MqttLocalDataSource localDataSource;

  MqttRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  // ------ Remote -----
  @override
  Future<Either<Failure, MqttServerClient>> connectMqttRepository({required MqttModel mqttModel}) async {
    try {
      final client = await remoteDataSource.connect(mqttModel: mqttModel).timeout(defaultTimeoutDuration);
      return Right(client);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException catch (e) {
      return Left(SocketFailure());
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on TimeoutException {
      return Left(TimeOutFailure());
    }
  }

  @override
  Future<Either<Failure, MqttServerClient>> disconnectMqttRepository({required MqttModel mqttModel}) async {
    try {
      final client = await remoteDataSource.disconnect(mqttModel: mqttModel).timeout(defaultTimeoutDuration);
      return Right(client);
    } on ServerException {
      return Left(ServerFailure());
    } on SocketException catch (e) {
      return Left(SocketFailure());
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on TimeoutException {
      return Left(TimeOutFailure());
    }
  }

  // ------ Local -----
  @override
  Future<Either<Failure, MqttModel>> getMqttDataByUsername({required String username}) async {
    try {
      final result = await localDataSource.getMqttDataByUsername(username: username);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> insertMqttData({required MqttModel mqttDataModel}) async {
    try {
      final result = await localDataSource.insertMqttData(mqttDataModel: mqttDataModel);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMqttDataByUsername({required String username}) async {
    try {
      final result = await localDataSource.deleteMqttDataByUsername(username: username);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } catch (e) {
      rethrow;
    }
  }
}
