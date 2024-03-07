import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'modules/splashscreen/presentation/pages/splash_screen.dart';

void main() {
  // di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light
          .copyWith(systemNavigationBarColor: Colors.grey[300], systemNavigationBarIconBrightness: Brightness.dark),
      child: MultiBlocProvider(
        providers: [

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
            navigatorObservers: [],
            home: const SplashScreen(),
            onGenerateRoute: (settings) => generateRoute(settings),
          )
        ),
      ),
    );
  }
}
