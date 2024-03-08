import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/get_mqtt.dart';
import 'package:mqtt_broker_app/modules/mqtt/domain/usecases/offline/insert_mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../domain/usecases/connect.dart';

part 'mqtt_event.dart';

part 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  // Remote / Online
  final MqttUseCaseConnect connect;

  // Offline / Cache
  final GetMqttCache getMqttCache;
  final InsertMqtt insertCache;

  MqttBloc({
    required this.connect,
    required this.getMqttCache,
    required this.insertCache,
  }) : super(MqttInitial()) {
    on<ConnectMqtt>((event, emit) async {
      late MqttServerClient serverClient;

      emit(MqttConnecting(isLoading: true));

      final result = await connect.execute(mqttModel: event.mqttModel);

      result.fold((failure) {
        emit(MqttConnecting(isLoading: false));
        emit(MqttError(message: failure.message));
        return;
      }, (client) {
        return serverClient = client;
      });

      if (serverClient.connectionStatus!.state == MqttConnectionState.connected) {
        final cacheMqtt = await insertCache.execute(mqttModel: event.mqttModel);

        cacheMqtt.fold((failure) {
          emit(MqttConnecting(isLoading: false));
          emit(MqttError(message: failure.message));
        }, (data) {
          emit(MqttConnecting(isLoading: false));
          emit(MqttConnected(message: 'Connected', mqttModel: event.mqttModel));
        });
      } else if (serverClient.connectionStatus!.state == MqttConnectionState.disconnected) {
        emit(MqttError(message: 'Disconnected'));
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
        // emit(MqttConnecting(isLoading: false));
        return mqttModel = data;
      });

      if (mqttModel != null) {
        final autoConnect = await connect.execute(mqttModel: mqttModel!);

        autoConnect.fold((failure) {
          emit(MqttConnecting(isLoading: false));
          emit(MqttError(message: failure.message));
        }, (serverClient) {
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
