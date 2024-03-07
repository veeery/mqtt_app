import 'package:flutter/cupertino.dart';
import 'package:mqtt_broker_app/modules/mqtt/presentation/pages/mqtt_screen.dart';
import 'package:mqtt_broker_app/modules/splashscreen/presentation/pages/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
    case MqttScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const MqttScreen());
    default:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
  }
}
