import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOverlay {
  // This Overlay for Android
  // To the specific is 3 Bottom/Navigation in some Android API 30 or below
  static final mySystemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.grey[300], systemNavigationBarIconBrightness: Brightness.dark);
}