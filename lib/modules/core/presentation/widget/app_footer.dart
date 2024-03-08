import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppFooter extends StatelessWidget {
  final Widget child;

  const AppFooter({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 100.w,
      // height: 6.5.h,
      child: child,
    );
  }
}
