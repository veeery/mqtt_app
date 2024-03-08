import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppFloatingHeader extends StatelessWidget {
  final Widget child;

  const AppFloatingHeader({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100.w,
      // height: 6.5.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: child,
    );
  }
}
