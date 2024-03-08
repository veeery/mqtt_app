import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/common/memory_data.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_body.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_scaffold.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_snackbar.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../../core/presentation/widget/app_button.dart';
import '../../../core/presentation/widget/app_custom_card.dart';
import '../../../core/presentation/widget/app_header.dart';
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

    return AppScaffold(
      appHeader: const AppHeader(
        // sideMenu: IconButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, MqttConfigurationScreen.routeName);
        //   },
        //   icon: const Icon(Icons.settings),
        // ),
        child: Text("MQTT Configuration"),
      ),
      appBody: AppBody(
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: BlocListener<MqttBloc, MqttState>(
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
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                BlocBuilder<MqttBloc, MqttState>(
                  builder: (context, state) {
                    if (state is MqttConnected) {
                      return AppCustomCard(
                        color: Colors.white38,
                        child: Column(
                          children: [
                            Text(state.message),
                            const Text('Your Last data cached'),
                            Text('Host: ${state.mqttModel.host}'),
                            Text('Port: ${state.mqttModel.port}'),
                            // IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever_rounded)), todo bikin delete cache mqtt
                          ],
                        ),
                      );
                    }
                    return AppCustomCard(
                      color: Colors.white38,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                          child: const Text('You not connected with any broker or host')),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                AppTextField(controller: hostController, labelText: "Host", hintText: "Enter Host"),
                SizedBox(height: 2.h),
                AppTextField(
                    controller: portController,
                    labelText: "Port",
                    hintText: "Enter Port",
                    keyboardType: TextInputType.number),
                SizedBox(height: 2.h),
                BlocBuilder<MqttBloc, MqttState>(
                  builder: (context, state) {
                    bool isLoading = false;

                    if (state is MqttConnecting) {
                      isLoading = state.isLoading;
                    }

                    if (state is MqttDisconnecting) {
                      isLoading = state.isLoading;
                    }

                    if (state is MqttConnected) {
                      MemoryData.mqttStatus = MqttConnectionState.connected;
                    }

                    if (state is MqttDisconnected) {
                      MemoryData.mqttStatus = MqttConnectionState.disconnected;
                    }

                    return AppButton(
                      text: MemoryData.mqttStatus == MqttConnectionState.disconnected ? "Connect" : "Disconnect",
                      color: MemoryData.mqttStatus == MqttConnectionState.disconnected ? Colors.green : Colors.red,
                      isLoading: isLoading,
                      onPressed: () {
                        if (portController.text.isEmpty || hostController.text.isEmpty) {
                          AppSnackBar().show(context: context, message: "Please enter host and port");
                          return;
                        }

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
      ),
    );
  }
}
