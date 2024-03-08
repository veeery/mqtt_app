import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/common/memory_data.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_snackbar.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../../core/presentation/widget/app_button.dart';
import '../../../core/presentation/widget/app_textfield.dart';

class MqttConfigurationScreen extends StatefulWidget {
  const MqttConfigurationScreen({Key? key}) : super(key: key);
  static const routeName = '/mqtt-configuration-screen';

  @override
  State<MqttConfigurationScreen> createState() => _MqttConfigurationScreenState();
}

class _MqttConfigurationScreenState extends State<MqttConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController hostController = TextEditingController(text: MemoryData.mqttModel?.host ?? "");
    final TextEditingController portController =
        TextEditingController(text: MemoryData.mqttModel?.port.toString() ?? "");

    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Configuration'),
      ),
      body: BlocListener<MqttBloc, MqttState>(
        listener: (context, state) {
          if (state is MqttConnected) {
            AppSnackBar().show(context: context, message: state.message);
            Navigator.of(context).pop();
          }

          if (state is MqttDisconnected) {
            AppSnackBar().show(context: context, message: state.message);
            Navigator.of(context).pop();
          }

          if (state is MqttError) {
            AppSnackBar().show(context: context, message: state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(controller: hostController, labelText: "Host", hintText: "Enter Host"),
              const SizedBox(height: 20),
              AppTextField(
                  controller: portController,
                  labelText: "Port",
                  hintText: "Enter Port",
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              BlocBuilder<MqttBloc, MqttState>(
                builder: (context, state) {
                  if (state is MqttConnected) {
                    MemoryData.mqttStatus = MqttConnectionState.connected;
                  }

                  if (state is MqttDisconnected) {
                    MemoryData.mqttStatus = MqttConnectionState.disconnected;
                  }

                  return AppButton(
                    text: MemoryData.mqttStatus == MqttConnectionState.disconnected ? "Connect" : "Disconnect",
                    color: MemoryData.mqttStatus == MqttConnectionState.disconnected ? Colors.green : Colors.red,
                    isLoading: MemoryData.mqttStatus == MqttConnectionState.disconnected ? state is MqttConnected : state is MqttDisconnected,
                    onPressed: () {
                      MqttModel model = MqttModel(
                        host: hostController.text,
                        username: "username",
                        password: "password",
                        port: int.parse(portController.text),
                      );

                      MemoryData.mqttStatus == MqttConnectionState.connected
                          ? context.read<MqttBloc>().add(DisconnectMqtt(mqttModel: model))
                          : context.read<MqttBloc>().add(ConnectMqtt(mqttModel: model));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
