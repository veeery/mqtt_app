import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppHeader extends StatelessWidget {
  // final String title;
  final Widget child;
  final Function()? onBack;
  final Widget? sideMenu;
  final bool? backButtonEnabled;

  const AppHeader({
    super.key,
    required this.child,
    this.onBack,
    this.sideMenu,
    this.backButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 100.w,
      // height: 6.5.h,
      child: Row(
        children: [
          const Spacer(flex: 1),
          Visibility(
            visible: backButtonEnabled!,
            child: IconButton(
              onPressed: () {
                onBack != null ? onBack!() : () {};
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded, size: 23.sp),
            ),
          ),
          const Spacer(flex: 1),
          child,
          const Spacer(flex: 25),
          sideMenu ?? Container(),
          Spacer(flex: sideMenu == null ? 1 : 2),
        ],
      ),
    );
  }
}
