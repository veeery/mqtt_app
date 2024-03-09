import 'package:flutter/cupertino.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/pages/mqtt_configuration.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/pages/mqtt_screen.dart';
import 'package:mqtt_broker_app/modules/settings/presentation/pages/setting_screen.dart';
import 'package:mqtt_broker_app/modules/splashscreen/presentation/pages/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
    case MqttScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const MqttScreen());
    case SettingScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const SettingScreen());
    case MqttConfigurationScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const MqttConfigurationScreen());
    default:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
  }
}
