import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';

import '../../../domain/usecases/connect.dart';

part 'mqtt_event.dart';
part 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttUseCaseConnect connect;

  MqttBloc({
    required this.connect,
  }) : super(MqttInitial()) {
    on<ConnectMqtt>((event, emit) async  {
      emit(MqttConnecting(isLoading: true));

      final result = await connect.execute(mqttModel: event.mqttModel);

      result.fold((failure) {
        emit(MqttConnecting(isLoading: false));
        emit(MqttError(message: failure.message));
      }, (client) {
        emit(MqttConnecting(isLoading: false));
        emit(MqttConnected(message: 'Connected'));
      });

    });
  }
}
