import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/common/memory_data.dart';
import 'package:mqtt_broker_app/modules/core/common/state_enum.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_body.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_custom_card.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_loading.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_message_input.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_scaffold.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_snackbar.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../core/presentation/widget/app_floating_header.dart';
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

    return AppScaffold(
      appHeader: AppHeader(
        title: "MQTT Broker App",
        backButtonEnabled: false,
        sideMenu: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MqttConfigurationScreen.routeName);
          },
          icon: const Icon(Icons.settings),
        ),
      ),
      appFloatingHeader: AppFloatingHeader(
        child: BlocBuilder<MqttBloc, MqttState>(
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

            if (state is MqttMessageSending) {
              return const AppCustomCard(
                color: Colors.white38,
                child: AppLoading(),
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

            return Text('MQTT ${state}');
          },
        ),
      ),
      appBody: AppBody(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: BlocBuilder<MqttBloc, MqttState>(
            builder: (context, state) {
              MqttServerClient? client;

              if ((state is MqttMessageSent) || (state is MqttSubscribed) || (state is MqttConnected)) {
                client = MemoryData.client!;
              }

              return client == null
                  ? const SizedBox()
                  : StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
                      stream: client.updates,
                      builder: (context, snapshot) {

                        print('snapshot: $snapshot');

                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.map((e) {
                              final MqttPublishMessage recMess = e.payload as MqttPublishMessage;
                              final String message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
                              return AppCustomCard(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text('Received message: $message'),
                                    Text('from topic: ${e.topic}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const AppCustomCard(
                            color: Colors.white,
                            child: AppLoading(),
                          );
                        }
                      },
                    );
            },
          ),
        ),
      ),
      appFooter: AppFooter(
        child: AppCustomCard(
          color: Colors.white,
          child: BlocListener<MqttBloc, MqttState>(
            listener: (context, state) {
              if (state is MqttError) {
                AppSnackBar().show(context: context, message: state.message);
              }
            },
            child: Column(
              children: [
                BlocBuilder<MqttBloc, MqttState>(
                  builder: (context, state) {
                    MqttStatusState statusState = MqttStatusState.none;

                    if (state is MqttSubscribed) {
                      topicController.text = state.topic;
                      statusState = MqttStatusState.subscribe;
                      MemoryData.mqttStatusState = statusState;
                    }

                    if (state is MqttUnsubscribed) {
                      topicController.text = state.topic;
                      statusState = MqttStatusState.unsubscribe;
                      MemoryData.mqttStatusState = statusState;
                    }

                    return MessageInput(
                      controller: topicController,
                      isLoading: state is MqttSubscribing,
                      onPressed: () {
                        if (statusState == MqttStatusState.unsubscribe || statusState == MqttStatusState.none) {
                          context.read<MqttBloc>().add(SubscribeMqtt(topic: topicController.text));
                        } else {
                          context.read<MqttBloc>().add(UnsubscribeMqtt(topic: topicController.text));
                        }
                      },
                      labelText: 'Topic ${statusState.name}',
                      iconData: (statusState == MqttStatusState.none || statusState == MqttStatusState.unsubscribe)
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
                      onPressed: () => context.read<MqttBloc>().add(
                            SendMessageMqtt(
                              message: messageController.text,
                              topic: topicController.text,
                            ),
                          ),
                      labelText: 'Message',
                      iconData: Icons.send_rounded,
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
