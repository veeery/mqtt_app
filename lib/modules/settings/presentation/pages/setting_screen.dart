import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_body.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_button.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_scaffold.dart';

import '../../../core/presentation/widget/app_header.dart';
import '../../../mqtt/presentation/pages/mqtt_configuration.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appHeader: AppHeader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Text('Settings', style: TextStyle(fontSize: 18.sp)),
        ),
      ),
      appBody: AppBody(
        child: ListView(
          children: [
            AppButton(
                onPressed: () => Navigator.pushNamed(context, MqttConfigurationScreen.routeName),
                text: 'MQTT Configuration'),
            SizedBox(height: 2.h),
            // Switch(
            //
            // ),
          ],
        ),
      ),
    );
  }
}
