import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';
import 'package:mqtt_broker_app/modules/core/presentation/widget/app_floating_header.dart';

import 'app_body.dart';
import 'app_footer.dart';
import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  final AppHeader? appHeader;
  final AppFloatingHeader? appFloatingHeader;
  final AppBody appBody;
  final AppFooter? appFooter;
  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    this.appHeader,
    this.appFloatingHeader,
    required this.appBody,
    this.appFooter,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          color: backgroundColor ?? Colors.white,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                Column(
                  children: [
                    appHeader ?? const SizedBox(),
                    appFloatingHeader ?? const SizedBox(),
                    appBody,
                  ],
                ),
                Positioned(
                  bottom: 0,
                  width: 100.w,
                  child: Center(
                    child: appFooter ?? const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
