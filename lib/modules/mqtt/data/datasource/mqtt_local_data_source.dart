import '../../../core/common/exception.dart';
import '../../../core/data/db/database_helper.dart';
import '../model/mqtt_model.dart';

abstract class MqttLocalDataSource {
  Future<bool> insertMqttData({required MqttModel mqttDataModel});

  Future<MqttModel> getMqttDataByUsername({required String username});
}

class MqttLocalDataSourceImpl implements MqttLocalDataSource {
  final DatabaseHelper databaseHelper;

  MqttLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> insertMqttData({required MqttModel mqttDataModel}) async {
    try {
      await databaseHelper.insert(model: mqttDataModel);
      return true;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MqttModel> getMqttDataByUsername({required String username}) async {
    try {
      final result = await databaseHelper.getDataByUsername(username: username);
      return MqttModel.fromJson(result);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
