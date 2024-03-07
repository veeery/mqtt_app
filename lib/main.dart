import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'injection.dart' as di;
import 'modules/core/common/app_overlay.dart';
import 'modules/core/common/utils.dart';
import 'modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';
import 'modules/mqtt/presentation/pages/mqtt_screen.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppOverlay.mySystemTheme,
      child: MultiBlocProvider(
        providers: [
          // Mqtt
          BlocProvider(create: (_) => di.locator<MqttBloc>()),
        ],
        child: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'test',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            navigatorObservers: [routeObserver],
            home: const MqttScreen(),
            onGenerateRoute: (settings) => generateRoute(settings),
          ),
        ),
      ),
    );
  }
}
