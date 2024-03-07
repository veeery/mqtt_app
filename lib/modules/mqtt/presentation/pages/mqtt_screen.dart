import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_button.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_textfield.dart';

class MqttScreen extends StatefulWidget {
  const MqttScreen({Key? key}) : super(key: key);
  static const routeName = '/mqtt-screen';

  @override
  State<MqttScreen> createState() => _MqttScreenState();
}

class _MqttScreenState extends State<MqttScreen> {
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
            AppTextField(controller: topicController, labelText: "Topic", hintText: "Enter topic"),
            const SizedBox(height: 20),
            AppButton(onPressed: () {}, text: 'Connect'),
            const SizedBox(height: 20),
            AppTextField(controller: topicController, labelText: "Message", hintText: "Enter Message"),
            const SizedBox(height: 20),
            AppButton(onPressed: () {}, text: 'Send'),
          ],
        ),
      ),
    );
  }
}
