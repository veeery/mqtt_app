import 'package:flutter/material.dart';
import 'package:mqtt_broker_app/modules/core/common/app_responsive.dart';

class AppBottomSheet extends StatefulWidget {
  final Widget child;

  const AppBottomSheet({
    super.key,
    required this.child,
  });

  @override
  State<AppBottomSheet> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppBottomSheet> with SingleTickerProviderStateMixin {
  bool minimized = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          minimized = !minimized;
          minimized ? _controller.forward() : _controller.reverse();
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.w),
            topRight: Radius.circular(2.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: minimized ? 5.h : 30.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(height: minimized ? 0.3.h : 1.h, duration: const Duration(milliseconds: 300)),
            AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller,
            ),
            AnimatedContainer(height: minimized ? 0.h : 1.h, duration: const Duration(milliseconds: 300)),
            Expanded(
              child: AnimatedOpacity(
                opacity: minimized ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: widget.child,
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
