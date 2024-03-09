import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle appOverlay(ThemeData themeData) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: themeData.brightness,
    systemNavigationBarColor: themeData.scaffoldBackgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
