import 'package:flutter/cupertino.dart';
import 'package:mqtt_broker_app/modules/splashscreen/presentation/pages/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
    default:
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
  }
}
