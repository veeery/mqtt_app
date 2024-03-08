import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppSnackBar {
  show({required BuildContext context, required String message, SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        // content: Text(message, style: kBodyTextBold),
        content: Text(message),
        duration: const Duration(seconds: 1),
        closeIconColor: Colors.white,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.w),
        ),
        action: snackBarAction,
      ),
    );
  }
}
