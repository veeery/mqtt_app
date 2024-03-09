import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/common/app_bottomsheet.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/common/memory_data.dart';
import 'package:mqtt_broker_app/modules/core/common/state_enum.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_body.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_custom_card.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_message_input.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_scaffold.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_snackbar.dart';
import 'package:mqtt_broker_app/modules/mqtt/data/model/mqtt_model.dart';
import 'package:mqtt_broker_app/modules/settings/presentation/pages/setting_screen.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/presentation/widget/app_footer.dart';
import '../../../core/presentation/widget/app_header.dart';
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
    final TextEditingController messageController = TextEditingController();

    final List<MqttReceivedMessage<MqttMessage>> messages = [];

    return AppScaffold(
      appHeader: AppHeader(
        backButtonEnabled: false,
        sideMenu: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SettingScreen.routeName);
          },
          icon: const Icon(Icons.settings),
        ),
        child: BlocBuilder<MqttBloc, MqttState>(
          builder: (context, state) {
            MqttModel? mqttModel = MemoryData.mqttModel;

            if (mqttModel != null) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("MQTT Broker App - ${mqttModel.host}",
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                    Text("Connected", style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
              );
            }

            return const Text("MQTT Broker App");
          },
        ),
      ),
      appBody: AppBody(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: BlocBuilder<MqttBloc, MqttState>(
            builder: (context, state) {
              MqttServerClient? client;

              if ((state is MqttMessageSent) || (state is MqttSubscribed) || (state is MqttConnected)) {
                client = MemoryData.client!;
                // setState(() {});
              }

              if (state is MqttEmpty) {
                return const AppCustomCard(
                  color: Colors.white38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You are not connected to the broker'),
                      Text('Please do the configuration first'),
                    ],
                  ),
                );
              }

              return client == null
                  ? const SizedBox()
                  : StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
                      stream: client.updates,
                      builder: (context, snapshot) {
                        print('snapshot: $snapshot');

                        if (snapshot.hasData) {
                          snapshot.data!.forEach((message) {
                            messages.add(message);
                          });

                          return ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final MqttPublishMessage recMess = messages[index].payload as MqttPublishMessage;
                              final String messageText =
                                  MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

                              if (messages == []) {
                                return const AppCustomCard(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Your messages will appear here'),
                                    ],
                                  ),
                                );
                              }

                              return AppCustomCard(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text('Received message: $messageText'),
                                    Text('from topic: ${messages[index].topic}'),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const AppCustomCard(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Your messages will appear here'),
                              ],
                            ),
                          );
                        }
                      },
                    );
            },
          ),
        ),
      ),
      appFooter: AppFooter(
        child: BlocBuilder<MqttBloc, MqttState>(
          builder: (context, state) {
            return MemoryData.mqttModel == null
                ? const SizedBox()
                : AppBottomSheet(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocConsumer<MqttBloc, MqttState>(
                            listener: (context, state) {
                              if (state is MqttSubscribed) {
                                AppSnackBar().show(context: context, message: "Subscribed to ${state.topic}");
                              }

                              if (state is MqttUnsubscribed) {
                                AppSnackBar().show(context: context, message: "Unsubscribed from ${state.topic}");
                              }
                            },
                            builder: (context, state) {
                              MqttStatusState statusState = MqttStatusState.none;
                              bool isLoading = false;

                              if (state is MqttSubscribing) {
                                isLoading = state.isLoading;
                              }

                              if (state is MqttUnsubscribing) {
                                isLoading = state.isLoading;
                              }

                              if (state is MqttSubscribed) {
                                topicController.text = state.topic;
                                statusState = MqttStatusState.subscribe;
                                MemoryData.mqttStatusState = statusState;
                                // AppSnackBar().show(context: context, message: "Subscribed to ${state.topic}");
                              }

                              if (state is MqttUnsubscribed) {
                                topicController.clear();
                                statusState = MqttStatusState.unsubscribe;
                                MemoryData.mqttStatusState = statusState;
                                // AppSnackBar().show(context: context, message: "Unsubscribed from ${state.topic}");
                              }

                              return MessageInput(
                                controller: topicController,
                                isLoading: isLoading,
                                isEnabled: (MemoryData.mqttStatusState == MqttStatusState.none ||
                                        MemoryData.mqttStatusState == MqttStatusState.unsubscribe)
                                    ? true
                                    : false,
                                onTap: () {
                                  if (topicController.text.isEmpty) {
                                    AppSnackBar().show(context: context, message: "You Topic is empty");
                                    return;
                                  }

                                  if (statusState == MqttStatusState.unsubscribe ||
                                      statusState == MqttStatusState.none) {
                                    context.read<MqttBloc>().add(SubscribeMqtt(topic: topicController.text));
                                  } else {
                                    context.read<MqttBloc>().add(UnsubscribeMqtt(topic: topicController.text));
                                  }
                                },
                                onPressed: () {
                                  if (topicController.text.isEmpty) {
                                    AppSnackBar().show(context: context, message: "You Topic is empty");
                                    return;
                                  }

                                  if (statusState == MqttStatusState.unsubscribe ||
                                      statusState == MqttStatusState.none) {
                                    context.read<MqttBloc>().add(SubscribeMqtt(topic: topicController.text));
                                  } else {
                                    context.read<MqttBloc>().add(UnsubscribeMqtt(topic: topicController.text));
                                  }
                                },
                                labelText: 'Topic',
                                iconData:
                                    (statusState == MqttStatusState.none || statusState == MqttStatusState.unsubscribe)
                                        ? Icons.topic_outlined
                                        : Icons.unsubscribe,
                              );
                            },
                          ),
                          SizedBox(height: 2.h),
                          BlocBuilder<MqttBloc, MqttState>(
                            builder: (context, state) {
                              return MessageInput(
                                isLoading: state is MqttMessageSending,
                                controller: messageController,
                                onPressed: () {
                                  if ((MemoryData.mqttStatusState == MqttStatusState.none) ||
                                      (MemoryData.mqttStatusState == MqttStatusState.unsubscribe)) {
                                    AppSnackBar()
                                        .show(context: context, message: "You are not subscribed to any topic");
                                    return;
                                  }

                                  if (messageController.text.isEmpty) {
                                    AppSnackBar().show(context: context, message: "You Message is empty");
                                    return;
                                  }

                                  context.read<MqttBloc>().add(
                                        SendMessageMqtt(
                                          message: messageController.text,
                                          topic: topicController.text,
                                        ),
                                      );
                                },
                                labelText: 'Message',
                                iconData: Icons.send_rounded,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
