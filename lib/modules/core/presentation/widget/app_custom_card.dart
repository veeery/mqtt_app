import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppCustomCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool enabled;

  const AppCustomCard({
    super.key,
    required this.child,
    required this.color,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Container(
          width: 90.w,
          margin: EdgeInsets.symmetric(
            // horizontal: 10.w,
            vertical: 5.w,
          ),
          child: child,
        ),
      ),
    );
  }
}
