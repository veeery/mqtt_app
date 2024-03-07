import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_button.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_textfield.dart';

import '../../data/model/mqtt_model.dart';
import '../bloc/mqtt/mqtt_bloc.dart';
import 'mqtt_configuration.dart';

class MqttScreen extends StatefulWidget {
  const MqttScreen({Key? key}) : super(key: key);
  static const routeName = '/mqtt-screen';

  @override
  State<MqttScreen> createState() => _MqttScreenState();
}

class _MqttScreenState extends State<MqttScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () async {
        // todo buat auto reconnect dari database
        context.read<MqttBloc>().add(
              const ConnectMqtt(
                mqttModel: MqttModel(
                  host: "",
                  username: "username",
                  password: "password",
                  port: "",
                ),
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController topicController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<MqttBloc, MqttState>(
              builder: (context, state) {
                if (state is MqttConnecting) {
                  return CircularProgressIndicator();
                }

                if (state is MqttConnected) {
                  return Text('Connected to the broker');
                }

                if (state is MqttError) {
                  return Column(
                    children: [
                      Text('You are not connected to the broker'),
                      Text('Please do the configuration first'),
                    ],
                  );
                }

                return Text('------');
              },
            ),
            AppTextField(controller: topicController, labelText: "Topic", hintText: "Enter topic"),
            const SizedBox(height: 20),
            AppButton(onPressed: () {}, text: 'Connect'),
            const SizedBox(height: 20),
            AppTextField(controller: topicController, labelText: "Message", hintText: "Enter Message"),
            const SizedBox(height: 20),
            AppButton(onPressed: () {}, text: 'Send'),
            const SizedBox(height: 20),
            AppButton(
                onPressed: () => Navigator.pushNamed(context, MqttConfigurationScreen.routeName),
                text: 'Configuration'),
          ],
        ),
      ),
    );
  }
}
