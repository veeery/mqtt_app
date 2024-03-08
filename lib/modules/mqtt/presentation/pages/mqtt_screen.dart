import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_button.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_custom_card.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_loading.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_textfield.dart';

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
        context.read<MqttBloc>().add(const GetMqttCacheEvent(username: "username"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController topicController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Broker App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MqttConfigurationScreen.routeName);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<MqttBloc, MqttState>(
              builder: (context, state) {
                if (state is MqttConnecting) {
                  return const AppCustomCard(
                    color: Colors.white38,
                    child: AppLoading(),
                  );
                }

                if (state is MqttConnected) {
                  return AppCustomCard(
                    color: Colors.white38,
                    child: Column(
                      children: [
                        Text(state.message),
                        const Text('Your Last data cached'),
                        Text('Host: ${state.mqttModel.host}'),
                        Text('Port: ${state.mqttModel.port}'),
                      ],
                    ),
                  );
                }

                if (state is MqttError) {
                  return const AppCustomCard(
                    color: Colors.white38,
                    child: Column(
                      children: [
                        Text('You are not connected to the broker'),
                        Text('Please do the configuration first'),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
            const Spacer(),
            AppCustomCard(
              color: Colors.white,
              child: Column(
                children: [
                  AppTextField(controller: topicController, labelText: "Topic", hintText: "Enter topic"),
                  const SizedBox(height: 20),
                  AppButton(onPressed: () {}, text: 'Connect'),
                  const SizedBox(height: 20),
                  AppTextField(controller: topicController, labelText: "Message", hintText: "Enter Message"),
                  const SizedBox(height: 20),
                  AppButton(onPressed: () {}, text: 'Send'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
