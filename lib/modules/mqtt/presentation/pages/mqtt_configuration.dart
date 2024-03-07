import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';

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
    final TextEditingController hostController = TextEditingController();
    final TextEditingController portController = TextEditingController();

    return Scaffold(
      body: BlocListener<MqttBloc, MqttState>(
        listener: (context, state) {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(controller: hostController, labelText: "Host", hintText: "Enter Host"),
              const SizedBox(height: 20),
              AppTextField(controller: portController, labelText: "Port", hintText: "Enter Port"),
              const SizedBox(height: 20),
              AppButton(
                onPressed: () {
                  context.read<MqttBloc>().add(
                        ConnectMqtt(
                          mqttModel: MqttModel(
                            // host: "broker.emqx.io",
                            host: hostController.text,
                            username: "username",
                            password: "password",
                            port: portController.text,
                            // port: "1883",
                          ),
                        ),
                      );
                },
                text: 'Connect',
              ),
              BlocBuilder<MqttBloc, MqttState>(
                builder: (context, state) {
                  return Text("$state");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
