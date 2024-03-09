import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppFooter extends StatelessWidget {
  final Widget child;

  const AppFooter({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      // height: 6.5.h,
      child: child,
    );
  }
}
