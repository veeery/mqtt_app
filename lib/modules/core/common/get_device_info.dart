import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

Future<String> getDeviceId() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      return 'deviceID=${build.androidId}';
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      return 'deviceID=${data.identifierForVendor}';
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
  return 'Failed to get device ID';
}
