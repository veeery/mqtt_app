import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/disconnect.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/get_mqtt.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/insert_mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../../core/common/memory_data.dart';
import '../../../domain/usecases/connect.dart';
import '../../../domain/usecases/offline/delete_mqtt.dart';

part 'mqtt_event.dart';
part 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  // Remote / Online
  final MqttUseCaseConnect connect;
  final MqttUseCaseDisconnect disconnect;

  // Offline / Cache
  final GetMqttCache getMqttCache;
  final InsertMqtt insertCache;
  final DeleteMqtt deleteCache;

  MqttBloc({
    required this.connect,
    required this.disconnect,
    required this.getMqttCache,
    required this.insertCache,
    required this.deleteCache,
  }) : super(MqttInitial()) {
    on<ConnectMqtt>((event, emit) async {
      late MqttServerClient serverClient;

      emit(MqttConnecting(isLoading: true));

      final result = await connect.execute(mqttModel: event.mqttModel);

      result.fold((failure) {
        emit(MqttConnecting(isLoading: false));
        emit(MqttError(message: failure.message));
      }, (client) {
        return serverClient = client;
      });

      if (serverClient.connectionStatus!.state == MqttConnectionState.connected) {
        final cacheMqtt = await insertCache.execute(mqttModel: event.mqttModel);

        cacheMqtt.fold((failure) {
          emit(MqttConnecting(isLoading: false));
          emit(MqttError(message: failure.message));
        }, (data) {
          MemoryData.mqttStatus = MqttConnectionState.connected;
          MemoryData.mqttModel = event.mqttModel;

          emit(MqttConnecting(isLoading: false));
          emit(MqttConnected(message: 'Connected', mqttModel: event.mqttModel));
        });
      } else if (serverClient.connectionStatus!.state == MqttConnectionState.disconnected) {
        emit(MqttError(message: 'Disconnected'));
      }
    });

    on<DisconnectMqtt>((event, emit) async {
      late MqttServerClient serverClient;

      emit(MqttDisconnecting(isLoading: true));

      final result = await disconnect.execute(mqttModel: event.mqttModel);

      result.fold((failure) {
        emit(MqttDisconnecting(isLoading: false));
        emit(MqttError(message: failure.message));
        return;
      }, (client) {
        emit(MqttDisconnected(message: "${client.connectionStatus!.state}", mqttModel: event.mqttModel));
        return serverClient = client;
      });

      if (serverClient.connectionStatus!.state == MqttConnectionState.disconnected) {
        // todo : remove the cache

        final cache = await deleteCache.execute(username: event.mqttModel.username);

        cache.fold((failure) {
          emit(MqttDisconnecting(isLoading: false));
          emit(MqttError(message: failure.message));
        }, (data) {
          MemoryData.mqttStatus = MqttConnectionState.disconnected;
          MemoryData.mqttModel = null;

          emit(MqttDisconnecting(isLoading: false));
          emit(MqttDisconnected(message: 'Disconnected', mqttModel: event.mqttModel));
        });
      } else {
        emit(MqttError(message: 'Unknown Error'));
      }
    });

    on<GetMqttCacheEvent>((event, emit) async {
      MqttModel? mqttModel;
      emit(MqttConnecting(isLoading: true));

      final result = await getMqttCache.execute(username: event.username);

      result.fold((failure) {
        emit(MqttConnecting(isLoading: false));
        emit(MqttError(message: failure.message));
      }, (data) {
        return mqttModel = data;
      });

      if (mqttModel != null) {
        final autoConnect = await connect.execute(mqttModel: mqttModel!);

        autoConnect.fold((failure) {
          emit(MqttConnecting(isLoading: false));
          emit(MqttError(message: failure.message));
        }, (serverClient) {
          MemoryData.mqttStatus = MqttConnectionState.connected;
          MemoryData.mqttModel = mqttModel;
          emit(MqttConnecting(isLoading: false));
          emit(MqttConnected(message: 'Connected', mqttModel: mqttModel!));
        });
      } else {
        emit(MqttConnecting(isLoading: false));
        emit(MqttError(message: "You don't have any mqtt data yet. Please connect to mqtt server first."));
      }
    });
  }
}
