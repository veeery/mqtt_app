import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'injection.dart' as di;
import 'modules/core/common/app_overlay.dart';
import 'modules/core/common/app_responsive.dart';
import 'modules/core/common/utils.dart';
import 'modules/mqtt/presentation/bloc/mqtt/mqtt_bloc.dart';
import 'modules/mqtt/presentation/pages/mqtt_screen.dart';
import 'modules/settings/presentation/bloc/theme_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Mqtt
        BlocProvider(create: (_) => di.locator<MqttBloc>()),
        BlocProvider(create: (_) => di.locator<ThemeBloc>()),
      ],
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return AnnotatedRegion(
              value: appOverlay(state.themeData),
              child: SafeArea(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'test',
                  theme: state.themeData,
                  builder: (context, child) {
                    AppResponsive.init(context: context);
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
            );
          },
        ),
      ),
    );
  }
}
