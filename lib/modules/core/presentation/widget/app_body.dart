import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool? isStack;

  const AppBody({
    super.key,
    required this.child,
    this.padding,
    this.physics,
    this.isStack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // child: AppLoadMore(
      //   event: () {},
      //   itemCount: 1,
      //   physics: physics,
      //   itemBuilder: (p0, p1) {
      //     return Padding(
      //       padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
      //       child: child,
      //     );
      //   },
      // ),
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
        child: child,
      ),
    );
  }

  Widget buildCardProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 5.w,
          child: Icon(Icons.person_rounded, size: 6.w),
        ),
        const Spacer(flex: 1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Very"),
            SizedBox(height: 0.7.h),
            Text("Senior Software Engineer"),
          ],
        ),
        const Spacer(flex: 18),
      ],
    );
  }
}
